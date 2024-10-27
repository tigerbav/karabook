import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class ImagesGridItem extends StatelessWidget {
  const ImagesGridItem(
    this.image, {
    super.key,
    required this.heroTag,
    this.size,
    required this.updImage,
    this.hasTag = false,
  });

  final ImageModel image;
  final String heroTag;
  final double? size;
  final Function() updImage;
  final bool hasTag;

  @override
  Widget build(BuildContext context) {
    if (image.imageRawData == null) return const SizedBox();

    final isCompleted = image.isCompleted == true;
    final Widget widget;
    final tag = heroTag + image.id.toString();

    if (image.screenProgress == null || isCompleted) {
      widget = Hero(
        tag: tag,
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: AppColors.shared.white.withOpacity(isCompleted ? 0 : 0.9),
          ),
          child: SvgPicture.string(
            image.imageRawData!,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      widget = Image.memory(
        image.toUint8List,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        alignment: const Alignment(0, -0.28),
      );
    }

    return GestureDetector(
      onTap: () async {
        if (isCompleted) {
          context.router.push(ImagePreviewRoute(
            imageData: image.imageRawData!,
            tag: tag,
          ));
          return;
        }
        if (image.imageRawData == null) return;

        await context.router.push(GameRoute(imageModel: image));
        updImage();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: size,
            height: size,
            clipBehavior: Clip.antiAlias,
            foregroundDecoration: _boxDecoration.copyWith(
              border: Border.all(
                color:
                    isCompleted ? AppColors.shared.pink : AppColors.shared.grey,
                width: 1.sp,
              ),
            ),
            decoration: _boxDecoration,
            child: widget,
          ),
          if (image.tag != null &&
              image.tag?.isNotEmpty == true &&
              image.tagName != null &&
              image.tagName?.isNotEmpty == true &&
              hasTag == true)
            Positioned(
              top: 10.sp,
              right: 10.sp,
              child: Container(
                padding: EdgeInsets.all(4.sp),
                decoration: BoxDecoration(
                  color: AppColors.shared.yellow,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  image.tagName!,
                  style: AppStyles.shared.settingsOption,
                ),
              ),
            )
        ],
      ),
    );
  }

  static final _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16.sp)),
  );
}
