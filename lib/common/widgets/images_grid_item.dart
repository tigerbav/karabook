import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/cubits/image/painter_progress_cubit.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class ImagesGridItem extends StatelessWidget {
  const ImagesGridItem(
    this.image, {
    super.key,
    required this.heroTag,
    this.size,
  });

  final ImageModel image;
  final String heroTag;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PainterProgressCubit(image.id),
      child: _ImagesGridItem(image, heroTag, size),
    );
  }
}

class _ImagesGridItem extends StatelessWidget {
  const _ImagesGridItem(this.image, this.heroTag, this.size);

  final ImageModel image;
  final String heroTag;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (image.imageRawData == null) return const SizedBox();

    return BlocBuilder<PainterProgressCubit, PainterProgressState>(
      builder: (context, state) {
        final isCompleted = state.painterProgress?.isCompleted == true;
        final Widget widget;
        final tag = heroTag + image.id.toString();

        if (state.isLoading) {
          widget = Center(
            child: SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: CircularProgressIndicator(
                color: AppColors.shared.pink,
              ),
            ),
          );
        } else if (state.painterProgress?.screenProgress == null) {
          widget = Hero(
            tag: tag,
            child: Container(
              foregroundDecoration: BoxDecoration(
                color:
                    AppColors.shared.white.withOpacity(isCompleted ? 0 : 0.9),
              ),
              child: SvgPicture.string(
                image.imageRawData!,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          widget = Image.memory(
            state.painterProgress!.toUint8List,
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
            if (image.imageRawData == null || state.isLoading) return;

            context.router.push(LoadingGameRoute(
              svgString: image.imageRawData!,
              id: image.id,
              painterProgressCubit: context.read<PainterProgressCubit>(),
              portfolioCubit: context.read<PortfolioCubit>(),
            ));
          },
          child: Container(
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
            // child: CachedNetworkSVGImage(
            //   'https://raw.githubusercontent.com/tigerbav/svg_images/main/image1.svg',
            // ),
          ),
        );
      },
    );
  }

  static final _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16.sp)),
  );
}
