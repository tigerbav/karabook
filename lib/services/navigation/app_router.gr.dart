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
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GameScreen(
          key: args.key,
          sortedShapes: args.sortedShapes,
          allShapes: args.allShapes,
          svgLines: args.svgLines,
          painterProgress: args.painterProgress,
          completedIds: args.completedIds,
          painterProgressCubit: args.painterProgressCubit,
          portfolioCubit: args.portfolioCubit,
        ),
      );
    },
    ImagePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<ImagePreviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ImagePreviewScreen(
          key: args.key,
          imageData: args.imageData,
          tag: args.tag,
        ),
      );
    },
    LibraryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LibraryScreen(),
      );
    },
    LoadingGameRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingGameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoadingGameScreen(
          key: args.key,
          svgString: args.svgString,
          id: args.id,
          painterProgressCubit: args.painterProgressCubit,
          portfolioCubit: args.portfolioCubit,
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
/// [GameScreen]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    required Map<Color, List<SvgShapeModel>> sortedShapes,
    required List<SvgShapeModel> allShapes,
    required List<SvgLineModel> svgLines,
    required PainterProgress painterProgress,
    required List<int> completedIds,
    required PainterProgressCubit painterProgressCubit,
    required PortfolioCubit portfolioCubit,
    List<PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            sortedShapes: sortedShapes,
            allShapes: allShapes,
            svgLines: svgLines,
            painterProgress: painterProgress,
            completedIds: completedIds,
            painterProgressCubit: painterProgressCubit,
            portfolioCubit: portfolioCubit,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const PageInfo<GameRouteArgs> page = PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.sortedShapes,
    required this.allShapes,
    required this.svgLines,
    required this.painterProgress,
    required this.completedIds,
    required this.painterProgressCubit,
    required this.portfolioCubit,
  });

  final Key? key;

  final Map<Color, List<SvgShapeModel>> sortedShapes;

  final List<SvgShapeModel> allShapes;

  final List<SvgLineModel> svgLines;

  final PainterProgress painterProgress;

  final List<int> completedIds;

  final PainterProgressCubit painterProgressCubit;

  final PortfolioCubit portfolioCubit;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, sortedShapes: $sortedShapes, allShapes: $allShapes, svgLines: $svgLines, painterProgress: $painterProgress, completedIds: $completedIds, painterProgressCubit: $painterProgressCubit, portfolioCubit: $portfolioCubit}';
  }
}

/// generated route for
/// [ImagePreviewScreen]
class ImagePreviewRoute extends PageRouteInfo<ImagePreviewRouteArgs> {
  ImagePreviewRoute({
    Key? key,
    required String imageData,
    required String tag,
    List<PageRouteInfo>? children,
  }) : super(
          ImagePreviewRoute.name,
          args: ImagePreviewRouteArgs(
            key: key,
            imageData: imageData,
            tag: tag,
          ),
          initialChildren: children,
        );

  static const String name = 'ImagePreviewRoute';

  static const PageInfo<ImagePreviewRouteArgs> page =
      PageInfo<ImagePreviewRouteArgs>(name);
}

class ImagePreviewRouteArgs {
  const ImagePreviewRouteArgs({
    this.key,
    required this.imageData,
    required this.tag,
  });

  final Key? key;

  final String imageData;

  final String tag;

  @override
  String toString() {
    return 'ImagePreviewRouteArgs{key: $key, imageData: $imageData, tag: $tag}';
  }
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
/// [LoadingGameScreen]
class LoadingGameRoute extends PageRouteInfo<LoadingGameRouteArgs> {
  LoadingGameRoute({
    Key? key,
    required String svgString,
    required int id,
    required PainterProgressCubit painterProgressCubit,
    required PortfolioCubit portfolioCubit,
    List<PageRouteInfo>? children,
  }) : super(
          LoadingGameRoute.name,
          args: LoadingGameRouteArgs(
            key: key,
            svgString: svgString,
            id: id,
            painterProgressCubit: painterProgressCubit,
            portfolioCubit: portfolioCubit,
          ),
          initialChildren: children,
        );

  static const String name = 'LoadingGameRoute';

  static const PageInfo<LoadingGameRouteArgs> page =
      PageInfo<LoadingGameRouteArgs>(name);
}

class LoadingGameRouteArgs {
  const LoadingGameRouteArgs({
    this.key,
    required this.svgString,
    required this.id,
    required this.painterProgressCubit,
    required this.portfolioCubit,
  });

  final Key? key;

  final String svgString;

  final int id;

  final PainterProgressCubit painterProgressCubit;

  final PortfolioCubit portfolioCubit;

  @override
  String toString() {
    return 'LoadingGameRouteArgs{key: $key, svgString: $svgString, id: $id, painterProgressCubit: $painterProgressCubit, portfolioCubit: $portfolioCubit}';
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
    required CategoryModel pack,
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

  final CategoryModel pack;

  @override
  String toString() {
    return 'VipRouteArgs{key: $key, pack: $pack}';
  }
}
