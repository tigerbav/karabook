import 'package:flutter/material.dart';
import 'package:karabookapp/common/app_colors.dart';

class AppStyles {
  static final shared = AppStyles._();

  AppStyles._()
      : toast = _toast,
        segment = _toast.copyWith(color: AppColors.shared.white),
        btn = _btn,
        packTitles = _btn.copyWith(color: AppColors.shared.black),
        packDescription = _packDescription,
        settingsOption = _settingsOption,
        politic = _politic,
        h1 = _h1;

  final TextStyle toast;
  final TextStyle segment;
  final TextStyle btn;
  final TextStyle packTitles;
  final TextStyle packDescription;
  final TextStyle settingsOption;
  final TextStyle politic;
  final TextStyle h1;

  static const _nunito = 'Nunito';

  static final TextStyle _toast = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.shared.black,
    fontFamily: _nunito,
  );

  static final TextStyle _btn = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.shared.white,
    fontFamily: _nunito,
  );

  static final TextStyle _packDescription = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.shared.black,
    fontFamily: _nunito,
  );

  static final TextStyle _settingsOption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.shared.black,
    fontFamily: _nunito,
  );

  static final TextStyle _politic = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w900,
    color: AppColors.shared.black,
    fontFamily: _nunito,
  );

  static final TextStyle _h1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.shared.black,
    fontFamily: _nunito,
  );
}
