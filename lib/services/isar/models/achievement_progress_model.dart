import 'package:isar/isar.dart';

part 'achievement_progress_model.g.dart';

@collection
class AchievementProgressModel {
  AchievementProgressModel({
    required this.id,
    this.userId,
    this.achievementId,
    this.isCompleted = false,
    this.isReceived = false,
    this.completedPoints = 0,
    this.modifiedDate,
  });

  final Id id;
  int? userId;
  int? achievementId;
  bool isCompleted;
  bool isReceived;
  int completedPoints;
  int? modifiedDate;

  factory AchievementProgressModel.fromJson(Map<String, dynamic> json) {
    return AchievementProgressModel(
      id: json['achivementsProgressId'],
      userId: json['userId'],
      achievementId: json['achivementId'],
      isCompleted: json['isCompleted'] ?? false,
      isReceived: json['isReceived'] ?? false,
      completedPoints: json['completedPoints'],
      modifiedDate: json['modifiedDate'],
    );
  }
}
