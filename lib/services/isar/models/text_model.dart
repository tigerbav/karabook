import 'package:isar/isar.dart';

part 'text_model.g.dart';

@collection
class TextModel {
  TextModel({
    this.id = Isar.autoIncrement,
    this.textKey,
    this.textValue,
    this.locale,
    this.modifiedDate,
  });

  final Id id;
  String? textKey;
  String? textValue;
  String? locale;
  int? modifiedDate;

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      textKey: json['textKey'],
      textValue: json['textValue'],
      locale: json['locale'],
      modifiedDate: json['modifiedDate'],
    );
  }
}
