import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_popup.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class CurrentEmailWidget extends StatelessWidget {
  const CurrentEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.shared.black,
                  width: 1.sp,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6.sp)),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.5.sp, horizontal: 8.sp),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.email ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 19,
                        color: AppColors.shared.black,
                        fontFamily: '.SF Pro Text',
                        letterSpacing: -0.41,
                        inherit: false,
                      ),
                    ),
                    SizedBox(width: 4.sp),
                    GestureDetector(
                      onTap: () => Utils.showPopUp(
                        context,
                        AppPopup(
                          description: LocaleKeys.exit_description.tr(),
                          onTapYes: context.read<SettingsCubit>().logout,
                        ),
                      ),
                      child: SvgPicture.asset(
                        AppResources.close,
                        width: 20.sp,
                        height: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
