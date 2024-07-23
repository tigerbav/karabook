import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:karabookapp/app/data/datasources/setting_datasource.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/cubits/image/painter_progress_cubit.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/game_screen/domain/repositories/game_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:screenshot/screenshot.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required this.repository,
    required this.sortedShapes,
    required this.svgLines,
    required this.painterProgressCubit,
    required this.portfolioCubit,
    required List<SvgShapeModel> allShapes,
    required PainterProgress painterProgress,
    required List<int> completedIds,
  }) : super(
          GameState(
            allShapes: allShapes,
            painterProgress: painterProgress,
            completedIds: completedIds,
          ),
        );

  Timer? _timer;

  final IGameRepository repository;
  final PainterProgressCubit painterProgressCubit;
  final PortfolioCubit portfolioCubit;

  final screenshotController = ScreenshotController();

  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final List<SvgLineModel> svgLines;

  void setSelectedShapes(Color? color) {
    emit(state.copyWith(
      selectedShapes: sortedShapes[color] ?? [],
      allShapes: _rewriteShapes,
    ));
  }

  Future<void> _saveProgress() async {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), () => saveGame());
  }

  Future<void> saveGame({bool saveServer = false}) async {
    final screenProgress = await screenshotController.capture();

    final painterProgress = state.painterProgress
      ..screenProgress = state.isCompleted ? null : screenProgress
      ..completedIds = state.isCompleted ? null : state.completedIds
      ..isCompleted = state.isCompleted;

    try {
      if (saveServer) await saveOnServer();
      await repository.updateImage(painterProgress);
    } catch (_) {
      debugPrint('Error updating image in local base!!!');
    }
  }

  //TODO: There is issue: if item from [state.selectedShapes] are painted
  //TODO: it will be rewrite
  List<SvgShapeModel> get _rewriteShapes {
    final paintedShapes =
        state.selectedShapes.where((e) => e.isPainted).toList();

    if (paintedShapes.isEmpty) return state.allShapes;

    final updatedShapes = state.allShapes.map((fromAllItem) {
      return paintedShapes
              .firstWhereOrNull(
                (fromSelectedItem) => fromAllItem.id == fromSelectedItem.id,
              )
              ?.copyWith(isPainted: true) ??
          fromAllItem;
    }).toList();

    return updatedShapes;
  }

  Future<bool> paintTappedShape(TapUpDetails details) async {
    final shapes = state.selectedShapes;
    if (shapes.isEmpty) return false;

    bool isPainted = false;
    int? tappedShapeId;

    final updatedShapes = shapes.map((e) {
      if (e.transformedPath.contains(details.localPosition) == true) {
        final completedId =
            state.completedIds.firstWhereOrNull((id) => id == e.id);
        if (completedId != null) return e;

        _saveProgress();
        tappedShapeId = e.id;
        isPainted = true;
        _vibrationEndColor();

        return e.copyWith(isPainted: true);
      }
      return e;
    }).toList();

    final completedIds =
        tappedShapeId == null ? null : List<int>.from(state.completedIds)
          ?..add(tappedShapeId!);

    emit(state.copyWith(
      selectedShapes: updatedShapes,
      completedIds: completedIds,
    ));

    return isPainted;
  }

  Future<void> _vibrationEndColor() async {
    final isVibrate = await SharedPrefManager.shared.get(C.vibration);
    if (isVibrate is bool && isVibrate == true) Vibrate.vibrate();
  }

  void finishGame() => emit(state.copyWith(status: GameStatus.completed));

  Future<void> exit() async {
    _timer?.cancel();
    await saveGame(saveServer: true);
    await painterProgressCubit.getProgress();
    await portfolioCubit.loadImages();
    emit(state.copyWith(status: GameStatus.exit));
  }

  Future<void> saveOnServer() async {
    final completedParts = state.isCompleted
        ? null
        : state.completedIds.map((e) => e.toString()).join(',');
    final progress = Progress(
      id: 0,
      userId: ISettingDataSource.userId,
      imageId: state.painterProgress.id,
      completedParts: completedParts,
      isCompleted: state.isCompleted,
    );
    await repository.updateServer(progress);
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
