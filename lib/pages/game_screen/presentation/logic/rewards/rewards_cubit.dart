import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'rewards_state.dart';

class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit() : super(const RewardsState()) {
    _createBannerAd();
    _createRewardedAd();
    _getHelpPoints();
  }

  var _numRewardedLoadAttempts = 0;

  Future<void> increaseHelpCount() async {
    await SharedPrefManager.share.write(C.helpCounter, state.helpCount - 1);
    emit(state.copyWith(helpCount: state.helpCount - 1));
  }

  Future<void> _getHelpPoints() async {
    final counter = await SharedPrefManager.share.get(C.helpCounter);

    emit(state.copyWith(
        helpCount: (counter != null && counter is int) ? counter : 2));
  }

  Future<void> _createBannerAd() async {
    final banner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => debugPrint('Ad loaded.'),
        //
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
          _createBannerAd();
        },
        //
        onAdOpened: (ad) {
          debugPrint('Ad opened.');
          loadBanner();
        },
        onAdClosed: (ad) {
          debugPrint('Ad closed.');
          emit(RewardsState(
            bannerAd: null,
            rewardedAd: state.rewardedAd,
            helpCount: state.helpCount,
          ));
        },
        onAdImpression: (ad) => debugPrint('Ad impression.'),
      ),
    );

    emit(RewardsState(
      bannerAd: banner,
      rewardedAd: state.rewardedAd,
      helpCount: state.helpCount,
    ));

    loadBanner();
  }

  Future<void> loadBanner() async {
    if (state.bannerAd == null) await _createBannerAd();
    await state.bannerAd?.load();
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _numRewardedLoadAttempts = 0;
          emit(RewardsState(
            bannerAd: state.bannerAd,
            rewardedAd: ad,
            helpCount: state.helpCount,
          ));
        },
        //
        onAdFailedToLoad: (error) {
          debugPrint('RewardedAd failed to load: $error');

          emit(RewardsState(
            bannerAd: state.bannerAd,
            rewardedAd: null,
            helpCount: state.helpCount,
          ));

          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= 10) _createRewardedAd();
        },
      ),
    );
  }

  void showRewardedAd() {
    if (state.rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      _createRewardedAd();
      return;
    }
    state.rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    state.rewardedAd?.setImmersiveMode(true);
    state.rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
      debugPrint(
        '$ad with reward $RewardItem(${reward.amount}, ${reward.type})',
      );

      await SharedPrefManager.share.write(C.helpCounter, state.helpCount + 2);
      emit(RewardsState(
        bannerAd: state.bannerAd,
        rewardedAd: state.rewardedAd,
        helpCount: state.helpCount + 2,
      ));

      return;
    });

    emit(RewardsState(
      bannerAd: state.bannerAd,
      rewardedAd: null,
      helpCount: state.helpCount,
    ));
  }
}
