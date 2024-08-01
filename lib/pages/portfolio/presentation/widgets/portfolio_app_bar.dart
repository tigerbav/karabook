import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:karabookapp/app/presentation/screens/settings_popup.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/utils/utils.dart';

class PortfolioAppBar extends AppBar {
  PortfolioAppBar(BuildContext context, {super.key})
      : super(
          surfaceTintColor: AppColors.shared.transparent,
          leadingWidth: double.infinity,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     context.router.push(const AchievementRoute());
                //   },
                //   child: SvgPicture.asset(AppResources.achievement),
                // ),
                GestureDetector(
                  onTap: () => Utils.showPopUp(context, const SettingsPopup()),
                  child: SvgPicture.asset(AppResources.settings),
                ),
              ],
            ),
          ),
        );
}
