import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/data/datasources/setting_datasource.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/services/isar/models/achievement_model.dart';
import 'package:karabookapp/services/isar/models/achievement_progress_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'achievement_state.dart';

class AchievementCubit extends Cubit<AchievementState> {
  AchievementCubit(this._repository) : super(const AchievementState()) {
    _init();
  }

  final IPortfolioRepository _repository;

  Future<void> _init() async {
    emit(state.copyWith(status: AchievementStatus.loading));
    final result = await _repository.getAllAchievements();
    result.fold(
      (l) => emit(state.copyWith(
        status: AchievementStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: AchievementStatus.success,
          allAchievements: r,
        ));
        _initMyProgress();
      },
    );
  }

  Future<void> _initMyProgress() async {
    final userId = await SharedPrefManager.shared.get(C.lastUserId);
    if (userId is! int || userId == 0) {
      emit(state.copyWith(status: AchievementStatus.noUser));
      return;
    }

    emit(state.copyWith(status: AchievementStatus.loadingProgress));
    final result = await _repository.getAchievementsProgresses();
    result.fold(
      (l) => emit(state.copyWith(
        status: AchievementStatus.failure,
        errorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          status: AchievementStatus.success,
          allProgressAchievements: r,
        ));
      },
    );
  }
}
