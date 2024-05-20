import 'package:isar/isar.dart';

part 'svg_image.g.dart';

@collection
class SvgImage {
  SvgImage({
    required this.id,
    this.imageRawData,
    this.categoryId,
    this.enabled = false,
    this.isDaily = false,
    this.modifiedDate,
  });

  late Id id;
  String? imageRawData;
  int? categoryId;
  bool enabled = false;
  bool isDaily = false;
  int? modifiedDate;

  factory SvgImage.fromJson(Map<String, dynamic> json) {
    return SvgImage(
      id: json['imageId'] as Id,
      imageRawData: json['imageRawData'],
      categoryId: json['categoryId'],
      enabled: json['enabled'],
      isDaily: json['isDaily'],
      modifiedDate: json['modifiedDate'],
    );
  }
}
