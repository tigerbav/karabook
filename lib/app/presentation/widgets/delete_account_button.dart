import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_popup.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.showPopUp(
        context,
        AppPopup(
          description: LocaleKeys.delete_description.tr(),
          onTapYes: context.read<SettingsCubit>().deleteAccount,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.shared.darkPurple,
          borderRadius: BorderRadius.all(Radius.circular(6.sp)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.5.sp, horizontal: 8.sp),
        child: Text(
          LocaleKeys.delete_account.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            color: AppColors.shared.white,
            fontFamily: '.SF Pro Text',
            letterSpacing: -0.41,
            inherit: false,
          ),
        ),
      ),
    );
  }
}