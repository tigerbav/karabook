import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';

@RoutePage()
class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    super.key,
    required this.imageData,
    required this.tag,
  });

  final String imageData;
  final String tag;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.shared.white,
      body: PopScope(
        canPop: false,
        child: Stack(
          children: [
            InteractiveViewer(
              transformationController: _transformationController,
              boundaryMargin: EdgeInsets.all(100.sp),
              maxScale: 25,
              child: Hero(
                tag: widget.tag,
                child: SvgPicture.string(
                  widget.imageData,
                  fit: BoxFit.contain,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppResources.back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
