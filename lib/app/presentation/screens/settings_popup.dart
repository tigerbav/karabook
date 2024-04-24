import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/app/presentation/widgets/settings_options_widget.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class SettingsPopup extends StatelessWidget {
  const SettingsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: AppColors.shared.white,
      ),
      padding: EdgeInsets.all(20.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.settings.tr(),
                style: AppStyles.shared.h1,
              ),
              GestureDetector(
                onTap: context.router.pop,
                child: SvgPicture.asset(AppResources.close),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          SettingsOptionsWidget(types: SettingsTypeEx.optionsWithSwitcher),
          SizedBox(height: 12.sp),
          SettingsOptionsWidget(types: SettingsTypeEx.optionsWithNoSwitcher),
          SizedBox(height: 20.sp),
          // Text(LocaleKeys.term_of_use.tr(), style: AppStyles.shared.politic),
          // SizedBox(height: 8.sp),
          Text(LocaleKeys.privacy_policy.tr(), style: AppStyles.shared.politic),
        ],
      ),
    );
  }
}
