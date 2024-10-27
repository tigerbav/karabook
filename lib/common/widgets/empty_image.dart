import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';

class EmptyImage extends StatelessWidget {
  const EmptyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.shared.grey),
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset(
              AppResources.octopus,
              fit: BoxFit.cover,
              color: AppColors.shared.black.withOpacity(0.1),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.shared.darkPurple,
              border: Border.all(color: AppColors.shared.purple),
            ),
            child: SvgPicture.asset(AppResources.lock),
          ),
        ],
      ),
    );
  }
}
