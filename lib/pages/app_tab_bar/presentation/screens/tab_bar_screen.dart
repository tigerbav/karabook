import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/enums/tab_bar_type.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/widgets/tab_bar_item.dart';
import 'package:karabookapp/pages/events/data/datasources/events_datasource.dart';
import 'package:karabookapp/pages/events/domain/repositories/events_repository.dart';
import 'package:karabookapp/pages/events/presentation/logic/comics/comics_cubit.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/pages/library/presentation/logic/banner/banner_cubit.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/pages/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

@RoutePage()
class TabBarScreen extends StatelessWidget {
  const TabBarScreen({Key? key}) : super(key: key);
  static TabsRouter? tabsRouter;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => EventsRepository(EventsDataSource()),
        ),
        RepositoryProvider(
          create: (_) => LibraryRepository(LibraryDataSource()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => BannerCubit(ctx.read<LibraryRepository>()),
          ),
          BlocProvider(
            create: (ctx) => LibraryCubit(ctx.read<LibraryRepository>()),
          ),
          BlocProvider(
            create: (_) => PortfolioCubit(
              PortfolioRepository(PortfolioDataSources()),
            ),
          ),
          BlocProvider(
            create: (ctx) => DailyCubit(ctx.read<EventsRepository>()),
          ),
          BlocProvider(
            create: (ctx) => ComicsCubit(ctx.read<EventsRepository>()),
          ),
        ],
        child: const _TabBarView(),
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        LibraryRoute(),
        EventsRoute(),
        PortfolioRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        TabBarScreen.tabsRouter = tabsRouter;

        // [widgets] is used because ListView doesn't allow apply Expanded
        List<Widget> widgets = [];
        for (var i = 0; i < TabBarType.values.length; i++) {
          widgets.add(TabBarItem(type: TabBarType.values[i]));
          if (i + 1 != TabBarType.values.length) widgets.add(const Spacer());
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40.sp),
          decoration: BoxDecoration(
            color: AppColors.shared.purple,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
          ),
          height: 1.sh * 0.1,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        );
      },
    );
  }
}
