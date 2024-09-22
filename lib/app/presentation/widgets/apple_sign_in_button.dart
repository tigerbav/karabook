import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      onPressed: () => context.read<SettingsCubit>().signInWithApple(context),
    );
  }
}
