// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AchievementRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AchievementScreen(),
      );
    },
    EmptyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmptyRoutePage(),
      );
    },
    EventsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EventsScreen(),
      );
    },
    LibraryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LibraryScreen(),
      );
    },
    PortfolioRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PortfolioScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    TabBarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TabBarScreen(),
      );
    },
    VipRoute.name: (routeData) {
      final args = routeData.argsAs<VipRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VipScreen(
          key: args.key,
          packs: args.packs,
          images: args.images,
        ),
      );
    },
  };
}

/// generated route for
/// [AchievementScreen]
class AchievementRoute extends PageRouteInfo<void> {
  const AchievementRoute({List<PageRouteInfo>? children})
      : super(
          AchievementRoute.name,
          initialChildren: children,
        );

  static const String name = 'AchievementRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EmptyRoutePage]
class EmptyRoute extends PageRouteInfo<void> {
  const EmptyRoute({List<PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EventsScreen]
class EventsRoute extends PageRouteInfo<void> {
  const EventsRoute({List<PageRouteInfo>? children})
      : super(
          EventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LibraryScreen]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute({List<PageRouteInfo>? children})
      : super(
          LibraryRoute.name,
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PortfolioScreen]
class PortfolioRoute extends PageRouteInfo<void> {
  const PortfolioRoute({List<PageRouteInfo>? children})
      : super(
          PortfolioRoute.name,
          initialChildren: children,
        );

  static const String name = 'PortfolioRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabBarScreen]
class TabBarRoute extends PageRouteInfo<void> {
  const TabBarRoute({List<PageRouteInfo>? children})
      : super(
          TabBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabBarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VipScreen]
class VipRoute extends PageRouteInfo<VipRouteArgs> {
  VipRoute({
    Key? key,
    required Pack packs,
    required List<SvgImage> images,
    List<PageRouteInfo>? children,
  }) : super(
          VipRoute.name,
          args: VipRouteArgs(
            key: key,
            packs: packs,
            images: images,
          ),
          initialChildren: children,
        );

  static const String name = 'VipRoute';

  static const PageInfo<VipRouteArgs> page = PageInfo<VipRouteArgs>(name);
}

class VipRouteArgs {
  const VipRouteArgs({
    this.key,
    required this.packs,
    required this.images,
  });

  final Key? key;

  final Pack packs;

  final List<SvgImage> images;

  @override
  String toString() {
    return 'VipRouteArgs{key: $key, packs: $packs, images: $images}';
  }
}
