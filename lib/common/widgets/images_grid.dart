import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

class ImagesGrid extends StatefulWidget {
  const ImagesGrid(this.images, {super.key});

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
      padding: EdgeInsets.all(20.sp).copyWith(top: 0),
      shrinkWrap: true,
      controller: _controller,
      itemCount: widget.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.sp,
        crossAxisSpacing: 16.sp,
      ),
      itemBuilder: (_, index) => ImagesGridItem(widget.images[index]),
    );
  }
}
