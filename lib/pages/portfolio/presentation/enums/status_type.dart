import 'package:easy_localization/easy_localization.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

enum StatusType { inProgress, completed }

extension StatusTypeEx on StatusType {
  String get title {
    switch (this) {
      case StatusType.inProgress:
        return LocaleKeys.in_progress.tr();
      case StatusType.completed:
        return LocaleKeys.completed.tr();
    }
  }
}
