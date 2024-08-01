import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/rewards/rewards_cubit.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardsCubit, RewardsState>(
      buildWhen: (p, c) => p.bannerAd != c.bannerAd,
      builder: (context, state) {
        final banner = state.bannerAd;
        if (banner == null) return const SizedBox();

        return Padding(
          padding: EdgeInsets.only(bottom: 10.sp),
          child: SizedBox(
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
            child: AdWidget(ad: banner),
          ),
        );
      },
    );
  }
}
