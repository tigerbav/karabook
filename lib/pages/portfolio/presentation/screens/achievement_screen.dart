import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/pages/portfolio/data/models/achievement.dart';
import 'package:percent_indicator/percent_indicator.dart';

@RoutePage()
class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          itemCount: C.achievementsLocalData.length,
          itemBuilder: (context, index) =>
              _Item(C.achievementsLocalData[index]),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.achievement);
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
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
      ),
      child: Row(
        children: [
          SizedBox(
            height: 72.sp,
            width: 72.sp,
            child: SvgPicture.asset(achievement.icon),
          ),
          SizedBox(width: 16.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title.toUpperCase(),
                  style: AppStyles.shared.packTitles,
                ),
                SizedBox(height: 2.sp),
                Text(
                  "${achievement.counter} ${achievement.subTitle.toUpperCase()}",
                  style: AppStyles.shared.toast,
                ),
                SizedBox(height: 5.sp),
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1500,
                  lineHeight: 2.sp,
                  percent: achievement.progress,
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
