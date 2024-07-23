import 'package:isar/isar.dart';

part 'locale_model.g.dart';

@collection
class LocaleModel {
  LocaleModel({
    this.id = Isar.autoIncrement,
    this.locale,
  });

  final Id id;
  String? locale;

  factory LocaleModel.fromJson(Map<String, dynamic> json) {
    return LocaleModel(
      locale: json['locale'],
    );
  }
}
