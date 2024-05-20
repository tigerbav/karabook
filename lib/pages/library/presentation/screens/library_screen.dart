import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_banner.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_categories.dart';
import 'package:karabookapp/pages/library/presentation/widgets/vip_list_view.dart';

@RoutePage()
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state.isFailure) Utils.showToast(context, state.errorMessage);
      },
      child: ListView(
        children: [
          const LibraryBanner(),
          SizedBox(height: 20.sp),
          const LibraryCategories(),
          SizedBox(height: 20.sp),
          BlocBuilder<LibraryCubit, LibraryState>(
            buildWhen: (p, c) =>
                p.imagesByCategory != c.imagesByCategory ||
                p.isLoadingImages != c.isLoadingImages ||
                p.currCategory != c.currCategory,
            builder: (context, state) {
              if (state.isLoadingImages) {
                return Center(
                  child: SizedBox(
                    width: 24.sp,
                    child: CircularProgressIndicator(
                      color: AppColors.shared.pink,
                    ),
                  ),
                );
              }

              // if (state.currCategory?.name == C.vip) return const VipListView();

              // final images = state.imagesByCategory;
              //
              // if (images == null || images.isEmpty) {
              //   return Container(
              //     alignment: Alignment.center,
              //     padding: EdgeInsets.only(top: 100.sp),
              //     child: Text(
              //       LocaleKeys.no_images.tr(),
              //       style: AppStyles.shared.h1,
              //     ),
              //   );
              // }

              return ImagesGrid(state.images);
            },
          ),
        ],
      ),
    );
  }
}
