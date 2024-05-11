import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/game_screen/domain/repositories/game_repository.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/game_core/painter_tools.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'loading_game_state.dart';

class LoadingGameCubit extends Cubit<LoadingGameState> {
  LoadingGameCubit({
    required this.repository,
    required this.svgString,
    required int id,
  }) : super(const LoadingGameState()) {
    _initGame();
    painterProgress.id = id;
  }
  final IGameRepository repository;

  final String svgString;
  final painterProgress = PainterProgress();

  final sortedShapes = <Color, List<SvgShapeModel>>{};
  final svgShapes = <SvgShapeModel>[];
  final svgLines = <SvgLineModel>[];
  late final FittedSizes fittedSizes;
  final completedIds = <int>[];
  late final int helps;

  Future<void> _initGame() async {
    // TODO: need to think about other way of realization without next line
    await Future.delayed(const Duration(seconds: 1));
    try {
      fittedSizes = PainterTools.shared.getFittedSize(svgString);
      PainterTools.shared.setLinesAndShapes(
        svgString: svgString,
        shapes: svgShapes,
        lines: svgLines,
        fs: fittedSizes,
      );

      final result = await repository.getProgress(painterProgress.id);
      result.either(
        (l) => emit(LoadingGameState(
          status: LoadingGameStatus.failure,
          errorMessage: state.errorMessage,
        )),
        (r) {
          _updateSvgShapes(r);
          completedIds.addAll(r);
        },
      );

      helps = await _getHelpPoints();

      emit(const LoadingGameState(status: LoadingGameStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(LoadingGameState(
        status: LoadingGameStatus.failure,
        errorMessage: LocaleKeys.something_went_wrong.tr(),
      ));
    }
  }

  Future<int> _getHelpPoints() async {
    final counter = await SharedPrefManager.share.get(C.helpCounter);

    return (counter != null && counter is int) ? counter : 2;
  }

  void _updateSvgShapes(List<int> ids) {
    final shapesWithProgress = List<SvgShapeModel>.from(svgShapes);
    svgShapes.clear();
    svgShapes.addAll(shapesWithProgress.map((e) {
      if (ids.contains(e.id)) return e.copyWith(isPainted: true);

      return e;
    }));

    sortedShapes.addAll(PainterTools.shared.setSortedShapes(svgShapes));
  }
}
