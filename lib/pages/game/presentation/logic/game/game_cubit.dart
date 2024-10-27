import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/game/domain/repositories/game_repository.dart';
import 'package:karabookapp/pages/game/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/game_core/painter_tools.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:screenshot/screenshot.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required this.repository,
    required ImageModel imageModel,
  }) : super(GameState(imageModel: imageModel)) {
    _init();
  }

  final IGameRepository repository;

  final _sortedShapes = <Color, List<SvgShapeModel>>{};
  final _svgShapes = <SvgShapeModel>[];
  final _svgLines = <SvgLineModel>[];

  final screenshotController = ScreenshotController();
  Timer? _timer;
  Timer? _timerServer;

  bool showPopup = true;

  Future<void> _init() async {
    final svgString = state.imageModel.imageRawData;
    if (svgString == null) {
      _error();
      return;
    }

    emit(state.copyWith(status: GameStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1500));

    final doNotShowAgain = await SharedPrefManager.shared.get(C.doNotShowAgain);
    if (doNotShowAgain is bool) showPopup = doNotShowAgain == false;

    final completeIds = state.imageModel.completedIds ?? [];

    try {
      PainterTools.shared.setLinesAndShapes(
        svgString: svgString,
        shapes: _svgShapes,
        lines: _svgLines,
        completedIds: completeIds,
      );

      _sortedShapes.addAll(PainterTools.shared.setSortedShapes(_svgShapes));

      emit(state.copyWith(
        status: GameStatus.completeInit,
        svgLines: _svgLines,
        sortedShapes: _sortedShapes,
        imageModel: state.imageModel.copyWith(completedIds: completeIds),
      ));
    } catch (e) {
      debugPrint(e.toString());
      _error();
    }
  }

  void _error() {
    emit(state.copyWith(
      status: GameStatus.failure,
      errorMessage: LocaleKeys.something_went_wrong.tr(),
    ));
  }

  Future<bool> paintTappedShape(TapUpDetails details) async {
    final shapes = state.selectedShapes;
    if (shapes.isEmpty) return false;

    var isPainted = false;
    int? tappedShapeId;

    final updSelectedShapes = shapes.map((e) {
      if (e.transformedPath.contains(details.localPosition) == true) {
        final id = state.imageModel.completedIds?.firstWhereOrNull(
          (id) => id == e.id,
        );
        if (id != null) return e;

        tappedShapeId = e.id;
        isPainted = true;

        return e.copyWith(isPainted: true);
      }
      return e;
    }).toList();

    if (tappedShapeId == null) return false;

    final completedIds = List<int>.from(state.imageModel.completedIds ?? []);
    completedIds.add(tappedShapeId!);

    emit(state.copyWith(
      status: GameStatus.idle,
      selectedShapes: updSelectedShapes,
      imageModel: state.imageModel.copyWith(completedIds: completedIds),
    ));

    _saveProgress();
    _tickerForServerRequest();
    _vibrationEndColor();

    return isPainted;
  }

  void setScale(double scale) {
    final int tempScale;
    if (scale > 0 && scale < 1) {
      tempScale = 1;
    } else if (scale > 1 && scale < 2) {
      tempScale = 2;
    } else if (scale > 2 && scale < 3) {
      tempScale = 3;
    } else if (scale > 3 && scale < 4) {
      tempScale = 4;
    } else if (scale > 4 && scale < 5) {
      tempScale = 5;
    } else if (scale > 5 && scale < 7) {
      tempScale = 7;
    } else {
      tempScale = 10;
    }

    if (tempScale == state.zoomScale) return;

    emit(state.copyWith(status: GameStatus.idle, zoomScale: tempScale));
  }

  void autoFill({
    required SvgShapeModel shape,
    required ColorPickerCubit pickerCubit,
  }) {
    final updSelectedShapes = state.selectedShapes.map((e) {
      if (e.id == shape.id) {
        return e.copyWith(isPainted: true);
      }
      return e;
    }).toList();

    final completedIds = List<int>.from(state.imageModel.completedIds ?? []);
    completedIds.add(shape.id);

    emit(state.copyWith(
      status: GameStatus.idle,
      selectedShapes: updSelectedShapes,
      imageModel: state.imageModel.copyWith(completedIds: completedIds),
    ));

    _saveProgress();
    _tickerForServerRequest();
    _vibrationEndColor();
    pickerCubit.incrementCompletedItem();
  }

  void _saveProgress() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () => _saveGame());
  }

  Future<void> _saveGame() async {
    var image = state.isCompleted
        ? ImageModel.completed(state.imageModel)
        : state.imageModel;

    final screenProgress = await screenshotController.capture();

    image = state.imageModel.copyWith(
      isCompleted: state.isCompleted,
      screenProgress: screenProgress,
    );
    await repository.updateImage(image);
  }

  Future<void> _vibrationEndColor() async {
    final isVibrate = await SharedPrefManager.shared.get(C.vibration);
    if (isVibrate is bool && isVibrate == true) {
      Vibrate.feedback(FeedbackType.success);
    }
  }

  void setSelectedShapes(Color? color) {
    _updateShapes();

    emit(GameState(
      status: GameStatus.idle,
      imageModel: state.imageModel,
      sortedShapes: state.sortedShapes,
      svgLines: state.svgLines,
      selectedShapes: state.sortedShapes[color] ?? [],
      zoomScale: state.zoomScale,
    ));
  }

  /// this part of code need for inserting [state.selectedShapes] in
  /// [state.sortedShapes]. I haven't found the other solution for watching
  /// of animation fill. To my mind, it should be emitted in
  /// [paintTappedShape()] method
  void _updateShapes() {
    var sortedShapes = state.sortedShapes;
    final lastColor = state.selectedShapes.firstOrNull?.fill;
    if (lastColor != null) {
      sortedShapes[lastColor] = state.selectedShapes;
    }
  }

  void finishGame() {
    emit(state.copyWith(status: GameStatus.completed, isCompleted: true));

    _saveGame();
  }

  Future<void> exit() async {
    if (state.isCompleted == false) {
      emit(state.copyWith(status: GameStatus.save));
    }

    _timer?.cancel();
    _timerServer?.cancel();
    // _updateShapes();
    try {
      await _saveGame();
      await _saveOnServer();
    } catch (_) {
      debugPrint('Error updating image in local base!!!');
    }
    emit(state.copyWith(status: GameStatus.exit));
  }

  void _tickerForServerRequest() {
    _timerServer?.cancel();
    _timerServer = Timer(const Duration(minutes: 1), () => _saveOnServer());
  }

  Future<void> _saveOnServer() async {
    final userId = await SharedPrefManager.shared.get(C.lastUserId);
    if (userId is! int? || userId == null || userId == 0) return;

    final completedParts = state.isCompleted
        ? null
        : state.imageModel.completedIds?.map((e) => e.toString()).join(',');
    final progress = Progress(
      userId: userId,
      imageId: state.imageModel.id,
      completedParts: completedParts,
      isCompleted: state.isCompleted,
      modifiedDate: DateTime.now().toUtc().millisecondsSinceEpoch,
    );
    repository.updateServer(progress);
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _timerServer?.cancel();
    return super.close();
  }
}
