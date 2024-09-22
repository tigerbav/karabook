import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

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
    this.isCompleted,
    this.completedIds,
    this.screenProgress,
  });

  late Id id;
  String? imageRawData;
  int? categoryId;
  bool enabled = false;
  bool isDaily = false;
  int sort = 0;
  int? modifiedDate;

  // local data
  bool? isCompleted;
  List<int>? completedIds;
  List<int>? screenProgress;

  // @ignore
  // Future<PainterProgress?> get progress async =>
  //     await isar.painterProgress.get(id);

  @ignore
  Uint8List get toUint8List => Uint8List.fromList(screenProgress ?? []);

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

  factory ImageModel.completed(ImageModel model) {
    return ImageModel(
      id: model.id,
      imageRawData: model.imageRawData,
      categoryId: model.categoryId,
      enabled: model.enabled,
      isDaily: model.isDaily,
      sort: model.sort,
      modifiedDate: model.modifiedDate,
      isCompleted: true,
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
    bool? isCompleted,
    List<int>? completedIds,
    List<int>? screenProgress,
  }) {
    return ImageModel(
      id: id ?? this.id,
      imageRawData: imageRawData ?? this.imageRawData,
      categoryId: categoryId ?? this.categoryId,
      enabled: enabled ?? this.enabled,
      isDaily: isDaily ?? this.isDaily,
      sort: sort ?? this.sort,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedIds: completedIds ?? this.completedIds,
      screenProgress: screenProgress ?? this.screenProgress,
    );
  }
}
