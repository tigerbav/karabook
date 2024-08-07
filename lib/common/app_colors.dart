import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static final AppColors shared = AppColors._();
  final _colors = LightColors();

  Color get black => _colors.blackColor;
  Color get white => _colors.whiteColor;
  Color get red => _colors.redColor;
  Color get yellow => _colors.yellow;
  Color get greenAccent => _colors.greenAccent;
  Color get pink => _colors.pink;
  Color get purple => _colors.purple;
  Color get darkPurple => _colors.darkPurple;
  Color get grey => _colors.grey;
  Color get darkGrey => _colors.darkGrey;
  Color get darkBlue => _colors.darkBlue;
  Color get lightGrey => _colors.lightGrey;
  Color get popupBg => _colors.popupBg;
  Color get colorPickerBg => _colors.colorPikerBg;
  Color get transparent => _colors.transparent;
}

abstract class IColor {
  late final Color redColor;
  late final Color yellow;
  late final Color blackColor;
  late final Color whiteColor;
  late final Color greenAccent;
  late final Color pink;
  late final Color purple;
  late final Color darkPurple;
  late final Color grey;
  late final Color darkGrey;
  late final Color darkBlue;
  late final Color lightGrey;
  late final Color popupBg;
  late final Color colorPikerBg;
  late final Color transparent;
}

class LightColors implements IColor {
  @override
  Color redColor = const Color(0xffff4650);

  @override
  Color blackColor = const Color(0xFF131010);

  @override
  Color yellow = const Color(0xFFFFEB3B);

  @override
  Color whiteColor = const Color(0xFFFCFCFC);

  @override
  Color greenAccent = const Color(0xFF69F0AE);

  @override
  Color pink = const Color(0xFFFF77FA);

  @override
  Color purple = const Color(0xFFE4B5FB);

  @override
  Color darkPurple = const Color(0xFF9B71B8);

  @override
  Color grey = const Color(0xFF828282);

  @override
  Color lightGrey = const Color(0xFFF4F4FC);

  @override
  Color darkGrey = const Color(0xFFD3D3D3);

  @override
  Color darkBlue = const Color(0xFF001B4B);

  @override
  Color popupBg = const Color(0x99331B27);

  @override
  Color colorPikerBg = const Color(0xFFE0F2F1);

  @override
  Color transparent = Colors.transparent;
}
