part of 'achievement_cubit.dart';

enum AchievementStatus {
  init,
  loading,
  loadingProgress,
  failure,
  success,
  noUser,
}

class AchievementState extends Equatable {
  const AchievementState({
    this.status = AchievementStatus.init,
    this.allAchievements = const [],
    this.allProgressAchievements = const [],
    this.errorMessage,
  });

  final AchievementStatus status;
  final List<AchievementModel> allAchievements;
  final List<AchievementProgressModel> allProgressAchievements;
  final String? errorMessage;

  bool get isLoading => status == AchievementStatus.loading;
  bool get isFailure => status == AchievementStatus.failure;
  bool get isLoadingProgress => status == AchievementStatus.loadingProgress;
  bool get isNoUser => status == AchievementStatus.noUser;

  double getProgressPercent(
    MapEntry<AchievementModel, AchievementProgressModel?> achievement,
  ) {
    if (achievement.key.maxPoints == 0) return 0.0;

    return (achievement.value?.completedPoints ?? 0) /
        achievement.key.maxPoints;
  }

  Map<AchievementModel, AchievementProgressModel?> get progress {
    final map = <AchievementModel, AchievementProgressModel?>{};
    for (final achievement in allAchievements) {
      final myProgress = allProgressAchievements
          .firstWhereOrNull((e) => e.achievementId == achievement.id);
      map[achievement] = myProgress;
    }

    return map;
  }

  AchievementState copyWith({
    AchievementStatus? status,
    List<AchievementModel>? allAchievements,
    List<AchievementProgressModel>? allProgressAchievements,
    String? errorMessage,
  }) {
    return AchievementState(
      status: status ?? this.status,
      allAchievements: allAchievements ?? this.allAchievements,
      allProgressAchievements:
          allProgressAchievements ?? this.allProgressAchievements,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allAchievements,
        allProgressAchievements,
        errorMessage,
      ];
}
