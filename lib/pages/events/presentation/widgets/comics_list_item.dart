import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

class ComicsListItem extends StatelessWidget {
  const ComicsListItem({
    super.key,
    required this.image,
    required this.isActive,
  });
  final SvgImage image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isActive)
          SizedBox(
            height: 100.sp,
            width: 100.sp,
            child: ImagesGridItem(image),
          )
        else
          Container(
            padding: EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.shared.grey),
              borderRadius: BorderRadius.all(Radius.circular(16.sp)),
            ),
            child: Image.asset(
              'assets/images/octopus.png',
              fit: BoxFit.contain,
              color: AppColors.shared.white,
            ),
          ),
        if (isActive)
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
    );
  }
}
