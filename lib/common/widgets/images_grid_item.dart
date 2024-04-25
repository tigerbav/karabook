import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class ImagesGridItem extends StatelessWidget {
  const ImagesGridItem(this.image, {super.key});

  final SvgImage image;

  @override
  Widget build(BuildContext context) {
    // if (image.isActive == false) return const SizedBox();

    return GestureDetector(
      onTap: () {
        context.router.push(LoadingRoute(
          svgString: image.imageParts,
          id: image.id,
        ));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
          border: Border.all(color: AppColors.shared.grey),
        ),
        child: image.screenProgress != null
            ? FractionallySizedBox(
                heightFactor: 2.0,
                widthFactor: 1.0,
                alignment: const Alignment(0, -0.3),
                child: Image(
                  image: MemoryImage(image.screenProgress!),
                  fit: BoxFit.cover,
                ),
              )
            : Opacity(
                opacity: 0.05,
                child: SvgPicture.string(
                  image.imageParts,
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }
}
