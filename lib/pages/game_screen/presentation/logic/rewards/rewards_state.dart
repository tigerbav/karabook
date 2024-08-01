part of 'rewards_cubit.dart';

class RewardsState extends Equatable {
  const RewardsState({
    this.bannerAd,
    this.rewardedAd,
    this.helpCount = 0,
    this.noAds = false,
  });

  final BannerAd? bannerAd;
  final RewardedAd? rewardedAd;
  final int helpCount;
  final bool noAds;

  RewardsState copyWith({
    BannerAd? bannerAd,
    RewardedAd? rewardedAd,
    int? helpCount,
    bool? noAds,
  }) {
    return RewardsState(
      bannerAd: bannerAd ?? this.bannerAd,
      rewardedAd: rewardedAd ?? this.rewardedAd,
      helpCount: helpCount ?? this.helpCount,
      noAds: noAds ?? this.noAds,
    );
  }

  @override
  List<Object?> get props => [bannerAd, rewardedAd, helpCount, noAds];
}
