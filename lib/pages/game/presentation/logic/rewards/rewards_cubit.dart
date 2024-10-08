import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'rewards_state.dart';

class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit() : super(const RewardsState()) {
    _init();
  }

  var _numRewardedLoadAttempts = 0;
  var _numBannerLoadAttempts = 0;

  Future<void> _init() async {
    final isAvailable = await PurchasesManager.shared.check(C.removeAds);

    if (isAvailable) {
      emit(state.copyWith(noAds: true));
    } else {
      _createBannerAd();
      _createRewardedAd();
      _getHelpPoints();
    }
  }

  Future<void> increaseHelpCount() async {
    await SharedPrefManager.shared.write(C.helpCounter, state.helpCount - 1);
    emit(state.copyWith(helpCount: max(0, state.helpCount - 1)));
  }

  Future<void> _getHelpPoints() async {
    final counter = await SharedPrefManager.shared.get(C.helpCounter);

    emit(state.copyWith(
      helpCount: (counter != null && counter is int) ? counter : 2,
    ));
  }

  Future<void> _createBannerAd() async {
    final banner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3407714794829576/5070824549'
          : 'ca-app-pub-3407714794829576/5380949767',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _numBannerLoadAttempts = 0;
          debugPrint('Ad loaded.');
        },
        //
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
          if (_numBannerLoadAttempts < 10) _createBannerAd();
          _numBannerLoadAttempts++;
        },
        //
        onAdOpened: (ad) {
          _numBannerLoadAttempts = 0;
          debugPrint('Ad opened.');
          loadBanner();
        },
        onAdClosed: (ad) {
          _numBannerLoadAttempts = 0;
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
          ? 'ca-app-pub-3407714794829576/2946358113'
          : 'ca-app-pub-3407714794829576/9887170987',
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

  void showRewardedAd(int count) {
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

      await SharedPrefManager.shared.write(
        C.helpCounter,
        state.helpCount + count,
      );
      emit(RewardsState(
        bannerAd: state.bannerAd,
        rewardedAd: state.rewardedAd,
        helpCount: state.helpCount + count,
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
