import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_refresh_indicator.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_banner.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_categories.dart';
import 'package:karabookapp/pages/library/presentation/widgets/vip_list_view.dart';

@RoutePage()
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Future<void> asd() async {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listener: (context, state) {
        if (state.isFailure) Utils.showToast(context, state.errorMessage);
      },
      child: AppRefreshIndicator(
        onRefresh: () => asd(),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const LibraryBanner(),
              SizedBox(height: 20.sp),
              const LibraryCategories(),
              BlocBuilder<LibraryCubit, LibraryState>(
                buildWhen: (p, c) =>
                    p.images != c.images || p.currCategory != c.currCategory,
                builder: (context, state) {
                  if (state.currCategory?.name == C.vip) {
                    return const VipListView();
                  }

                  return ImagesGrid(images: state.images);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
