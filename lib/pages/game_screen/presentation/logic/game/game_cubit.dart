import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/game_screen/domain/repositories/game_repository.dart';
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

  final IGameRepository repository;

  final screenshotController = ScreenshotController();

  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final List<SvgLineModel> svgLines;

  void setSelectedShapes(Color? color) {
    emit(state.copyWith(
      selectedShapes: sortedShapes[color] ?? [],
      allShapes: _rewriteShapes,
    ));
  }

  Future<void> saveData() async {
    final screenProgress = await screenshotController.capture();

    final painterProgress = state.painterProgress
      ..screenProgress = state.isCompleted ? null : screenProgress
      ..completedIds = state.isCompleted ? null : state.completedIds
      ..isCompleted = state.isCompleted;

    try {
      repository.updateImage(painterProgress);
    } catch (_) {
      debugPrint('Error update image in local base!!!');
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

  Future<void> paintTappedShape(TapUpDetails details) async {
    final shapes = state.selectedShapes;
    if (shapes.isEmpty) return;

    GameStatus? tappedStatus;
    int? tappedShapeId;

    final updatedShapes = shapes.map((e) {
      if (e.transformedPath.contains(details.localPosition) == true) {
        final completedId =
            state.completedIds.firstWhereOrNull((id) => id == e.id);
        if (completedId != null) return e;

        tappedStatus = GameStatus.shapeTapped;
        tappedShapeId = e.id;
        _vibrationEndColor();

        return e.copyWith(isPainted: true);
      }
      return e;
    }).toList();

    final completedIds =
        tappedShapeId == null ? null : List<int>.from(state.completedIds)
          ?..add(tappedShapeId!);

    emit(state.copyWith(
      status: tappedStatus,
      selectedShapes: updatedShapes,
      completedIds: completedIds,
    ));
  }

  void setStatusIdle() => emit(state.copyWith(status: GameStatus.idle));

  Future<void> _vibrationEndColor() async {
    final isVibrate = await SharedPrefManager.share.get(C.vibration);
    if (isVibrate is bool && isVibrate == true) Vibrate.vibrate();
  }

  void finishGame() => emit(state.copyWith(status: GameStatus.completed));
  void exit() => emit(state.copyWith(status: GameStatus.exit));

  @override
  Future<void> close() async {
    await saveData();
    return super.close();
  }
}
