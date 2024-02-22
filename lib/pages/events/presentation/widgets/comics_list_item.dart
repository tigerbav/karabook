import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';

class ComicsListItem extends StatelessWidget {
  const ComicsListItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.shared.grey),
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/octopus.png',
            fit: BoxFit.contain,
            color: index != 0 ? AppColors.shared.white : null,
          ),
          if (index == 0)
            Positioned(
              top: 5.sp,
              right: 5.sp,
              child: Container(
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.shared.darkPurple,
                  border: Border.all(color: AppColors.shared.purple),
                ),
                child: SvgPicture.asset(AppResources.unlock),
              ),
            )
          else
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
