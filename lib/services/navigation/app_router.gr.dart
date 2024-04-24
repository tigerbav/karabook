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
    ContactUsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactUsScreen(),
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
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoadingScreen(
          svgString: args.svgString,
          id: args.id,
          key: args.key,
        ),
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
    SvgViewRoute.name: (routeData) {
      final args = routeData.argsAs<SvgViewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SvgViewScreen(
          painterProgressModel: args.painterProgressModel,
          svgShapes: args.svgShapes,
          svgLines: args.svgLines,
          sortedShapes: args.sortedShapes,
          fittedSvgSize: args.fittedSvgSize,
          key: args.key,
        ),
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
          pack: args.pack,
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
/// [ContactUsScreen]
class ContactUsRoute extends PageRouteInfo<void> {
  const ContactUsRoute({List<PageRouteInfo>? children})
      : super(
          ContactUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactUsRoute';

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
/// [LoadingScreen]
class LoadingRoute extends PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    required String svgString,
    required int id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoadingRoute.name,
          args: LoadingRouteArgs(
            svgString: svgString,
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const PageInfo<LoadingRouteArgs> page =
      PageInfo<LoadingRouteArgs>(name);
}

class LoadingRouteArgs {
  const LoadingRouteArgs({
    required this.svgString,
    required this.id,
    this.key,
  });

  final String svgString;

  final int id;

  final Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{svgString: $svgString, id: $id, key: $key}';
  }
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
/// [SvgViewScreen]
class SvgViewRoute extends PageRouteInfo<SvgViewRouteArgs> {
  SvgViewRoute({
    required PainterProgressModel painterProgressModel,
    required List<SvgShapeModel> svgShapes,
    required List<SvgLineModel> svgLines,
    required Map<Color, List<SvgShapeModel>> sortedShapes,
    required FittedSizes fittedSvgSize,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SvgViewRoute.name,
          args: SvgViewRouteArgs(
            painterProgressModel: painterProgressModel,
            svgShapes: svgShapes,
            svgLines: svgLines,
            sortedShapes: sortedShapes,
            fittedSvgSize: fittedSvgSize,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SvgViewRoute';

  static const PageInfo<SvgViewRouteArgs> page =
      PageInfo<SvgViewRouteArgs>(name);
}

class SvgViewRouteArgs {
  const SvgViewRouteArgs({
    required this.painterProgressModel,
    required this.svgShapes,
    required this.svgLines,
    required this.sortedShapes,
    required this.fittedSvgSize,
    this.key,
  });

  final PainterProgressModel painterProgressModel;

  final List<SvgShapeModel> svgShapes;

  final List<SvgLineModel> svgLines;

  final Map<Color, List<SvgShapeModel>> sortedShapes;

  final FittedSizes fittedSvgSize;

  final Key? key;

  @override
  String toString() {
    return 'SvgViewRouteArgs{painterProgressModel: $painterProgressModel, svgShapes: $svgShapes, svgLines: $svgLines, sortedShapes: $sortedShapes, fittedSvgSize: $fittedSvgSize, key: $key}';
  }
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
    required Pack pack,
    List<PageRouteInfo>? children,
  }) : super(
          VipRoute.name,
          args: VipRouteArgs(
            key: key,
            pack: pack,
          ),
          initialChildren: children,
        );

  static const String name = 'VipRoute';

  static const PageInfo<VipRouteArgs> page = PageInfo<VipRouteArgs>(name);
}

class VipRouteArgs {
  const VipRouteArgs({
    this.key,
    required this.pack,
  });

  final Key? key;

  final Pack pack;

  @override
  String toString() {
    return 'VipRouteArgs{key: $key, pack: $pack}';
  }
}
