import 'package:isar/isar.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

part 'image_model.g.dart';

@collection
class ImageModel {
  ImageModel({
    required this.id,
    this.imageRawData,
    this.categoryId,
    this.enabled = false,
    this.isDaily = false,
    this.sort = 0,
    this.modifiedDate,
  });

  late Id id;
  String? imageRawData;
  int? categoryId;
  bool enabled = false;
  bool isDaily = false;
  int sort = 0;
  int? modifiedDate;

  @ignore
  Future<PainterProgress?> get progress async =>
      await isar.painterProgress.get(id);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    dynamic modifiedDate = json['modifiedDate'];
    if (modifiedDate != null && modifiedDate is String) {
      modifiedDate = int.tryParse(modifiedDate);
    } else if (modifiedDate is! int) {
      modifiedDate = null;
    }

    return ImageModel(
      id: json['imageId'] as Id,
      imageRawData: json['imageRawData'],
      categoryId: json['categoryId'],
      enabled: json['enabled'] ?? false,
      isDaily: json['isDaily'] ?? false,
      sort: json['sort'] ?? 0,
      modifiedDate: modifiedDate,
    );
  }

  ImageModel copyWith({
    Id? id,
    String? imageRawData,
    int? categoryId,
    bool? enabled,
    bool? isDaily,
    int? sort,
    int? modifiedDate,
  }) {
    return ImageModel(
      id: id ?? this.id,
      imageRawData: imageRawData ?? this.imageRawData,
      categoryId: categoryId ?? this.categoryId,
      enabled: enabled ?? this.enabled,
      isDaily: isDaily ?? this.isDaily,
      sort: sort ?? this.sort,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }
}
