import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karabookapp/pages/contact_us/presentation/screens/contact_us_screen.dart';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/screens/tab_bar_screen.dart';
import 'package:karabookapp/pages/events/presentation/screens/events_screen.dart';
import 'package:karabookapp/pages/game/presentation/screens/loading_screen.dart';
import 'package:karabookapp/pages/game_screen/presentation/screens/game_screen.dart';
import 'package:karabookapp/pages/game_screen/presentation/screens/loading_game_screen.dart';
import 'package:karabookapp/pages/library/presentation/screens/library_screen.dart';
import 'package:karabookapp/pages/library/presentation/screens/vip_screen.dart';
import 'package:karabookapp/pages/portfolio/presentation/screens/achievement_screen.dart';
import 'package:karabookapp/pages/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:karabookapp/pages/splash/presentation/screens/splash_screen.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/navigation/empty_route_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter(GlobalKey<NavigatorState> navigatorKey)
      : super(navigatorKey: navigatorKey);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRoute.page),
        AutoRoute(
          page: TabBarRoute.page,
          children: [
            AutoRoute(
              page: EmptyRoute.page,
              children: [
                AutoRoute(initial: true, page: LibraryRoute.page),
                AutoRoute(page: VipRoute.page),
              ],
            ),
            AutoRoute(page: EventsRoute.page),
            AutoRoute(page: PortfolioRoute.page),
          ],
        ),
        AutoRoute(page: LoadingRoute.page),
        //
        AutoRoute(page: AchievementRoute.page),
        AutoRoute(page: ContactUsRoute.page),
        AutoRoute(page: LoadingGameRoute.page),
        AutoRoute(page: GameRoute.page),
      ];
}
