import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({super.key});

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
          Text(
            LocaleKeys.exit_description.tr(),
            style: AppStyles.shared.settingsOption,
          ),
          SizedBox(height: 30.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: context.router.pop,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.shared.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                    ),
                    padding: EdgeInsets.all(20.sp),
                    child: Text(
                      LocaleKeys.no.tr(),
                      textAlign: TextAlign.center,
                      style: AppStyles.shared.btnBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<SettingsCubit>().logout();
                    context.router.pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.shared.darkPurple,
                      borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                    ),
                    padding: EdgeInsets.all(20.sp),
                    child: Text(
                      LocaleKeys.yes.tr(),
                      textAlign: TextAlign.center,
                      style: AppStyles.shared.btn,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
