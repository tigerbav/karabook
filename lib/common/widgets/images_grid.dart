import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/widgets/empty_image.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/common/widgets/loading_widget.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

class ImagesGrid extends StatefulWidget {
  const ImagesGrid(
    this.images, {
    super.key,
    required this.heroTag,
    required this.imageType,
    this.isLoading = false,
    this.isScrollable = true,
  });

  final List<ImageModel?> images;
  final String heroTag;
  final ImageType imageType;
  final bool isLoading;
  final bool isScrollable;

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
    return ListView(
      shrinkWrap: true,
      physics: widget.isScrollable
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        GridView.builder(
          padding: EdgeInsets.all(20.sp).copyWith(top: 0),
          shrinkWrap: true,
          controller: _controller,
          itemCount: widget.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.sp,
            crossAxisSpacing: 16.sp,
          ),
          itemBuilder: (_, index) {
            if (widget.images[index] == null) {
              return const EmptyImage(isInfinityW: true);
            }

            return ImagesGridItem(
              widget.images[index]!,
              key: ValueKey(widget.images[index]!.id),
              heroTag: widget.heroTag,
              updImage: () => widget.imageType.updImage(
                context,
                widget.images[index]!,
              ),
            );
          },
        ),
        if (widget.isLoading)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            child: const LoadingWidget(),
          ),
      ],
    );
  }
}
