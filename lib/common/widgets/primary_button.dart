import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.action,
    this.isBig = false,
  });

  final String text;
  final VoidCallback action;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: isBig ? 19.sp : 8.sp,
        ),
        decoration: BoxDecoration(
          color: AppColors.shared.darkPurple,
          borderRadius: BorderRadius.all(Radius.circular(22.sp)),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.shared.btn,
        ),
      ),
    );
  }
}
