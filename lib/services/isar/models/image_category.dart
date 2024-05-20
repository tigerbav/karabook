import 'package:isar/isar.dart';

part 'image_category.g.dart';

@collection
class ImageCategory {
  ImageCategory({
    required this.id,
    this.name,
    this.description,
    this.categoryPreview,
    this.enabled = false,
    this.categoryTypeId,
    this.modifiedDate,
  });

  late Id id;
  String? name;
  String? description;
  List<int>? categoryPreview;
  bool enabled = false;
  int? categoryTypeId;
  String? modifiedDate;

  factory ImageCategory.fromMap(Map<String, dynamic> map) {
    return ImageCategory(
      id: map['id'] as Id,
      name: map['name'] as String,
      description: map['description'] as String,
      categoryPreview: map['categoryPreview'] as List<int>,
      enabled: map['enabled'] as bool,
      categoryTypeId: map['categoryTypeId'] as int,
      modifiedDate: map['modifiedDate'] as String,
    );
  }
}
