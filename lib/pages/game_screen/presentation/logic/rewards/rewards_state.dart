part of 'rewards_cubit.dart';

class RewardsState extends Equatable {
  const RewardsState({
    this.bannerAd,
    this.rewardedAd,
    this.helpCount = 0,
  });

  final BannerAd? bannerAd;
  final RewardedAd? rewardedAd;
  final int helpCount;

  RewardsState copyWith({
    BannerAd? bannerAd,
    RewardedAd? rewardedAd,
    int? helpCount,
  }) {
    return RewardsState(
      bannerAd: bannerAd ?? this.bannerAd,
      rewardedAd: rewardedAd ?? this.rewardedAd,
      helpCount: helpCount ?? this.helpCount,
    );
  }

  @override
  List<Object?> get props => [bannerAd, rewardedAd, helpCount];
}
