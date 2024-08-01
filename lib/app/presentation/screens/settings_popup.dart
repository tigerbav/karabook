import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/app/presentation/widgets/google_sign_in_btn.dart';
import 'package:karabookapp/app/presentation/widgets/settings_options_widget.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/network/links.dart';

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
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (p, c) => p.isAds != c.isAds,
            builder: (context, state) {
              return SettingsOptionsWidget(
                types: SettingsTypeEx.optionsWithNoSwitcher(state.isAds),
              );
            },
          ),
          SizedBox(height: 20.sp),
          const GoogleSignInButton(),
          SizedBox(height: 20.sp),
          GestureDetector(
            onTap: () => Utils.launchURL(Links.privacy),
            child: Text(
              LocaleKeys.privacy_policy.tr(),
              style: AppStyles.shared.politic,
            ),
          ),
        ],
      ),
    );
  }
}
