import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/app/presentation/widgets/apple_sign_in_button.dart';
import 'package:karabookapp/app/presentation/widgets/current_email_widget.dart';
import 'package:karabookapp/app/presentation/widgets/delete_account_button.dart';
import 'package:karabookapp/app/presentation/widgets/google_sign_in_btn.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        final noEmail = state.hasEmail == false;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.hasEmail) const CurrentEmailWidget(),
            if (state.hasEmail) SizedBox(height: 6.sp),
            if (noEmail) const GoogleSignInButton(),
            if (noEmail) SizedBox(height: 6.sp),
            if (Platform.isIOS && noEmail) const AppleSignInButton(),
            if (Platform.isIOS && noEmail) SizedBox(height: 6.sp),
            if (state.hasEmail) const DeleteAccountButton(),
          ],
        );
      },
    );
  }
}
