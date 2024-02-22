import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.action,
  });

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        decoration: BoxDecoration(
          color: AppColors.shared.darkPurple,
          borderRadius: BorderRadius.all(Radius.circular(22.sp)),
        ),
        child: Text(
          text,
          style: AppStyles.shared.btn,
        ),
      ),
    );
  }
}
