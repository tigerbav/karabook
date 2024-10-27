import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_popup.dart';
import 'package:karabookapp/common/widgets/empty_image.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

class ComicsListItem extends StatelessWidget {
  const ComicsListItem({
    super.key,
    required this.image,
    required this.isActive,
  });

  final ImageModel image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive == false) {
          Utils.showPopUp(
            context,
            AppPopup(
              description: LocaleKeys.please_complete_the_last_picture.tr(),
              justDescription: true,
            ),
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isActive)
            SizedBox(
              height: 100.sp,
              width: 100.sp,
              child: ImagesGridItem(
                image,
                heroTag: C.comics,
                size: 100,
                updImage: () => ImageType.freeComics.updImage(context, image),
              ),
            )
          else
            const EmptyImage(),
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
      ),
    );
  }
}
