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
          imageModel: args.imageModel,
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
    required ImageModel imageModel,
    List<PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            imageModel: imageModel,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const PageInfo<GameRouteArgs> page = PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.imageModel,
  });

  final Key? key;

  final ImageModel imageModel;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, imageModel: $imageModel}';
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
