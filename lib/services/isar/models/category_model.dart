import 'package:isar/isar.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/text_model.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  CategoryModel({
    required this.id,
    this.nameKey,
    this.descriptionKey,
    this.categoryPreview,
    this.enabled = false,
    this.categoryTypeId,
    this.sort,
    this.modifiedDate,
  }) {
    _getNameAndDescription();
  }

  late Id id;
  String? nameKey;
  String? descriptionKey;
  String? categoryPreview;
  bool enabled = false;
  int? categoryTypeId;
  int? sort;
  int? modifiedDate;

  @ignore
  String? name;
  @ignore
  String? description;

  Future<void> _getNameAndDescription() async {
    final texts = await IsarService.shared.getObjects(from: isar.textModels);
    name ??= texts.firstWhereOrNull((e) => e.textKey == nameKey)?.textValue;
    description ??=
        texts.firstWhereOrNull((e) => e.textKey == descriptionKey)?.textValue;
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['categoryId'] as Id,
      nameKey: json['categoryNameKey'],
      descriptionKey: json['categoryDescriptionKey'],
      categoryPreview: json['categoryPreview'],
      enabled: json['enabled'],
      categoryTypeId: json['categoryTypeId'],
      sort: json['sort'],
      modifiedDate: json['modifiedDate'],
    );
  }
}
