import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/pages/events/presentation/widgets/daily_grid.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';

class DailyWidget extends StatefulWidget {
  const DailyWidget({super.key});

  @override
  State<DailyWidget> createState() => _DailyWidgetState();
}

class _DailyWidgetState extends State<DailyWidget>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152.sp,
      child: BlocBuilder<DailyCubit, DailyState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.shared.pink),
            );
          }

          if (state.images.isEmpty) {
            return Center(
              child: Text(LocaleKeys.soon.tr(), style: AppStyles.shared.h1),
            );
          }

          late final cubit = context.read<DailyCubit>();

          final image = state.images.firstOrNull;
          // final imageWidget = image?.imageRawData != null
          //     ? Image(
          //         image: MemoryImage(image!.screenProgress!),
          //         fit: BoxFit.cover,
          //       )
          //     : SvgPicture.string(image!.imageRawData!);

          if (image == null) return const SizedBox();

          return ListView(
            controller: _scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: cubit.decreaseOpacity,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 152.sp,
                  decoration: BoxDecoration(
                    border: state.isGotGift
                        ? null
                        : Border.all(color: AppColors.shared.pink),
                    borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                  ),
                  child: AnimatedOpacity(
                    onEnd: cubit.increaseOpacity,
                    opacity: state.opacity,
                    duration: const Duration(seconds: 2),
                    child: state.isGotGift
                        ? ImagesGridItem(
                            image,
                            heroTag: C.daily,
                            size: 152.sp,
                            updImage: () => ImageType.daily.updImage(
                              context,
                              image,
                            ),
                          )
                        : Image.asset(
                            AppResources.dailyGift,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              const DailyGrid(),
            ],
          );
        },
      ),
    );
  }
}
