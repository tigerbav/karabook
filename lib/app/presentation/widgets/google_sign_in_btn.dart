import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.shared.black,
          width: 1.sp,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppResources.google, width: 20.sp, height: 20.sp),
          SizedBox(width: 4.sp),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (p, c) => p.email != c.email,
            builder: (context, state) {
              final cubit = context.read<SettingsCubit>();
              return Row(
                children: [
                  GestureDetector(
                    onTap: state.hasEmail ? null : cubit.getUserEmail,
                    child: Text(
                      state.email ?? LocaleKeys.sign_in_with_google.tr(),
                      style: AppStyles.shared.settingsOption,
                    ),
                  ),
                  if (state.hasEmail) ...[
                    SizedBox(width: 4.sp),
                    GestureDetector(
                      onTap: cubit.getUserEmail,
                      child: SvgPicture.asset(
                        AppResources.close,
                        width: 20.sp,
                        height: 20.sp,
                      ),
                    ),
                  ],
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
