import 'package:karabookapp/common/app_resources.dart';

enum TabBarType {
  library,
  events,
  portfolio,
}

extension TabBarTypeEx on TabBarType {
  String get lottie {
    switch (this) {
      case TabBarType.library:
        return AppResources.library;
      case TabBarType.events:
        return AppResources.events;
      case TabBarType.portfolio:
        return AppResources.portfolio;
    }
  }
}
