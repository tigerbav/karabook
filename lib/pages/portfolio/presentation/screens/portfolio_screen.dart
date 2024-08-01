import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/portfolio/presentation/enums/status_type.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/pages/portfolio/presentation/widgets/portfolio_app_bar.dart';
import 'package:karabookapp/pages/portfolio/presentation/widgets/work_status.dart';

@RoutePage()
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(context),
      body: Column(
        children: [
          const WorkStatus(),
          SizedBox(height: 20.sp),
          Expanded(
            child: BlocConsumer<PortfolioCubit, PortfolioState>(
              listenWhen: (p, c) => p.completedLength != c.completedLength,
              listener: (context, state) {
                context.read<PortfolioCubit>().loadImages();
              },
              buildWhen: (p, c) =>
                  p.statusType != c.statusType || p.isLoading != c.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 100.sp),
                      child: CircularProgressIndicator(
                        color: AppColors.shared.pink,
                      ),
                    ),
                  );
                }
                final isInProgress = state.statusType == StatusType.inProgress;
                final images =
                    isInProgress ? state.progressImages : state.completedImages;
                late final emptyImagesText = isInProgress
                    ? LocaleKeys.no_progress_pictures.tr()
                    : LocaleKeys.any_finished_paintings.tr();

                if (images.isNotEmpty) {
                  // return ListView(children: [ImagesGrid(images)]);
                  return ImagesGrid(images, heroTag: C.portfolio);
                }

                return Center(
                  child: Text(
                    emptyImagesText,
                    textAlign: TextAlign.center,
                    style: AppStyles.shared.packDescription,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
