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

  Future<void> _init() async {
    final svgString = state.imageModel.imageRawData;
    if (svgString == null) {
      _error();
      return;
    }

    emit(state.copyWith(status: GameStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      PainterTools.shared.setLinesAndShapes(
        svgString: svgString,
        shapes: _svgShapes,
        lines: _svgLines,
        completedIds: state.imageModel.completedIds ?? [],
      );

      _sortedShapes.addAll(PainterTools.shared.setSortedShapes(_svgShapes));

      final helps = await _getHelpPoints();

      emit(state.copyWith(
        status: GameStatus.completeInit,
        helps: helps,
        svgLines: _svgLines,
        sortedShapes: _sortedShapes,
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

  Future<int> _getHelpPoints() async {
    final counter = await SharedPrefManager.shared.get(C.helpCounter);

    return (counter != null && counter is int) ? counter : 2;
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

  void autoFill({
    required SvgShapeModel shape,
    required bool autoFill,
    required ColorPickerCubit pickerCubit,
  }) {
    if (autoFill == false) return;

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
    _timer = Timer(const Duration(seconds: 2), () => _saveGame());
  }

  Future<void> _saveGame({bool isExit = false}) async {
    var image = state.isCompleted
        ? ImageModel.completed(state.imageModel)
        : state.imageModel;

    if (isExit) {
      final screenProgress = await screenshotController.capture();

      image = state.imageModel.copyWith(
        isCompleted: state.isCompleted,
        screenProgress: screenProgress,
      );
    }

    try {
      if (isExit) await _saveOnServer();
      await repository.updateImage(image);
    } catch (_) {
      debugPrint('Error updating image in local base!!!');
    }
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
      helps: state.helps,
      sortedShapes: state.sortedShapes,
      svgLines: state.svgLines,
      selectedShapes: state.sortedShapes[color] ?? [],
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

  void finishGame() => emit(state.copyWith(status: GameStatus.completed));

  Future<void> exit() async {
    if (state.isCompleted == false) {
      emit(state.copyWith(status: GameStatus.save));
    }

    _timer?.cancel();
    _timerServer?.cancel();
    _updateShapes();
    await _saveGame(isExit: true);
    emit(state.copyWith(status: GameStatus.exit));
  }

  void _tickerForServerRequest() {
    _timer?.cancel();
    _timer = Timer(const Duration(minutes: 1), () => _saveOnServer());
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
    await repository.updateServer(progress);
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _timerServer?.cancel();
    return super.close();
  }
}
