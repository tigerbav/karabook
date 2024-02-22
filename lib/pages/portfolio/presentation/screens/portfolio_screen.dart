import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/enums/status_type.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/pages/portfolio/presentation/widgets/portfolio_app_bar.dart';
import 'package:karabookapp/pages/portfolio/presentation/widgets/work_status.dart';

@RoutePage()
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioCubit(
        PortfolioRepository(PortfolioDataSources()),
      ),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatelessWidget {
  const _PortfolioView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(),
      body: ListView(
        children: [
          const WorkStatus(),
          BlocBuilder<PortfolioCubit, PortfolioState>(
            buildWhen: (p, c) =>
                p.statusType != c.statusType || p.isLoading != c.isLoading,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 100.sp),
                    child:
                        CircularProgressIndicator(color: AppColors.shared.pink),
                  ),
                );
              }
              //TODO
              if (state.statusType == StatusType.inProgress) {
                return ImagesGrid(images: state.progressImages);
              } else {
                return ImagesGrid(images: state.completedImages);
              }
            },
          ),
        ],
      ),
    );
  }
}
