import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class EventsAppBar extends AppBar {
  EventsAppBar({super.key})
      : super(
          surfaceTintColor: AppColors.shared.transparent,
          leadingWidth: double.infinity,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.daily.tr(),
                  style: AppStyles.shared.h1,
                ),
                SvgPicture.asset(AppResources.notification),
              ],
            ),
          ),
        );
}
