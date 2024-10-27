import 'package:isar/isar.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/text_model.dart';

part 'achievement_model.g.dart';

@collection
class AchievementModel {
  AchievementModel({
    required this.id,
    this.nameKey,
    this.descriptionKey,
    this.image,
    this.enabled = false,
    this.maxPoints = 0,
    this.modifiedDate,
  }) {
    _getNameAndDescription();
  }

  final Id id;
  String? nameKey;
  String? descriptionKey;
  String? image;
  bool enabled;
  int maxPoints;
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

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['achivementId'],
      nameKey: json['achivementsNameKey'],
      descriptionKey: json['achivementsDescriptionKey'],
      image: json['image'],
      enabled: json['enabled'] ?? false,
      maxPoints: json['achivementsMaxPoints'] ?? 0,
      modifiedDate: json['modifiedDate'],
    );
  }
}
