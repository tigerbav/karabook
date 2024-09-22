import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/common/widgets/loading_widget.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_banner.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_categories.dart';
import 'package:karabookapp/pages/library/presentation/widgets/vip_list_view.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';

@RoutePage()
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state.isFailure) Utils.showToast(context, state.errorMessage);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _controller,
        primary: false,
        children: [
          const LibraryBanner(),
          SizedBox(height: 20.sp),
          const LibraryCategories(),
          SizedBox(height: 20.sp),
          BlocBuilder<LibraryCubit, LibraryState>(
            buildWhen: (p, c) =>
                p.imagesByCategory != c.imagesByCategory ||
                p.currCategory != c.currCategory ||
                p.isLoadingImages != c.isLoadingImages ||
                p.isPagination != c.isPagination ||
                p.mapImages != c.mapImages,
            builder: (context, state) {
              if (state.currCategory?.id == C.vipID) {
                return const VipListView();
              }

              final images = state.imagesByCategory;

              if (state.isLoadingImages && images.isEmpty) {
                return const SizedBox();
              }

              if (images.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 100.sp),
                  child: Text(
                    LocaleKeys.no_images.tr(),
                    style: AppStyles.shared.h1,
                  ),
                );
              }

              return ImagesGrid(
                images,
                heroTag: C.library,
                imageType: ImageType.byCategory,
                isLoading: state.isPagination,
              );
            },
          ),
          BlocBuilder<LibraryCubit, LibraryState>(
            buildWhen: (p, c) => p.isLoadingImages != c.isLoadingImages,
            builder: (context, state) {
              if (state.isLoadingImages == false) return const SizedBox();

              return const LoadingWidget();
            },
          ),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}
