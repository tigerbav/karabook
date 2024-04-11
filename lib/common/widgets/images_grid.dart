import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class ImagesGrid extends StatefulWidget {
  const ImagesGrid({
    super.key,
    required this.images,
  });

  final List<SvgImage> images;

  @override
  State<ImagesGrid> createState() => _ImagesGridState();
}

class _ImagesGridState extends State<ImagesGrid> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20.sp),
      shrinkWrap: true,
      controller: _controller,
      itemCount: widget.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.sp,
        crossAxisSpacing: 16.sp,
      ),
      itemBuilder: (context, index) => _Item(image: widget.images[index]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.image});
  final SvgImage image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(LoadingRoute(
          svgString: image.imageParts,
          id: image.id,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
          border: Border.all(color: AppColors.shared.grey),
        ),
        child: image.screenProgress != null
            ? Image(
                image: MemoryImage(image.screenProgress!),
                fit: BoxFit.cover,
              )
            : SvgPicture.string(image.svgOnlyStroke),
      ),
    );
  }
}
