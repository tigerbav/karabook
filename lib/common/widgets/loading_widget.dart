import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.sp,
        height: 24.sp,
        child: CircularProgressIndicator(
          color: AppColors.shared.pink,
        ),
      ),
    );
  }
}
