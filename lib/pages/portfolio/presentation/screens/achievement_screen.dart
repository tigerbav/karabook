import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_popup.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/achievement/achievement_cubit.dart';
import 'package:karabookapp/services/isar/models/achievement_model.dart';
import 'package:karabookapp/services/isar/models/achievement_progress_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

@RoutePage()
class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AchievementCubit(ctx.read<IPortfolioRepository>()),
      child: const _AchievementScreen(),
    );
  }
}

class _AchievementScreen extends StatelessWidget {
  const _AchievementScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: BlocConsumer<AchievementCubit, AchievementState>(
          listenWhen: (p, c) =>
              p.isFailure != c.isFailure || p.isNoUser != c.isNoUser,
          listener: (context, state) {
            if (state.isFailure) {
              Utils.showToast(
                context,
                LocaleKeys.something_went_wrong.tr(),
              );
            } else if (state.isNoUser) {
              Utils.showPopUp(
                context,
                AppPopup(
                  description:
                      LocaleKeys.please_sing_in_to_see_your_progress.tr(),
                  justDescription: true,
                ),
              );
            }
          },
          buildWhen: (p, c) => p.progress != c.progress,
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              itemCount: state.progress.length,
              itemBuilder: (context, index) {
                final achievement = state.progress.entries.toList()[index];
                return _Item(
                  achievement,
                  state.getProgressPercent(achievement),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.achievement, this.percent);
  final MapEntry<AchievementModel, AchievementProgressModel?> achievement;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final aKey = achievement.key;
    final aValue = achievement.value;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
      margin: EdgeInsets.only(bottom: 16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(254, 248, 255, 1),
            Color.fromRGBO(254, 242, 255, 1),
          ],
        ),
        border: Border.all(
          color: aValue?.isCompleted == true
              ? AppColors.shared.yellow
              : AppColors.shared.transparent,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 72.sp,
            width: 72.sp,
            child: aKey.image == null
                ? Image.asset(AppResources.octopus, fit: BoxFit.cover)
                : SvgPicture.string(aKey.image!, fit: BoxFit.cover),
          ),
          SizedBox(width: 16.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aKey.name?.toUpperCase() ?? LocaleKeys.oops.tr(),
                  style: AppStyles.shared.packTitles,
                ),
                SizedBox(height: 2.sp),
                Text(
                  "${min(aValue?.completedPoints ?? 0, aKey.maxPoints)}/${aKey.maxPoints} ${aKey.description?.toUpperCase() ?? LocaleKeys.oops.tr()}",
                  style: AppStyles.shared.toast,
                ),
                SizedBox(height: 5.sp),
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1500,
                  lineHeight: 2.sp,
                  percent: percent,
                  backgroundColor: const Color.fromRGBO(255, 214, 253, 1),
                  progressColor: const Color.fromRGBO(189, 0, 255, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
