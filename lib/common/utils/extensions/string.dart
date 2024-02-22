import 'package:easy_localization/easy_localization.dart';

extension StringEx on String {
  DateTime? get time => DateTime.tryParse(this);
}
