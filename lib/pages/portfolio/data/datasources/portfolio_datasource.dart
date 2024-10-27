import 'dart:async';

import 'package:isar/isar.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/achievement_model.dart';
import 'package:karabookapp/services/isar/models/achievement_progress_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class IPortfolioDataSources {
  Stream<List<ImageModel>> getImages(bool isCompleted);
  Future<List<AchievementModel>> getAllAchievements();
  Future<List<AchievementProgressModel>> getAchievementsProgresses();
}

class PortfolioDataSources extends IPortfolioDataSources {
  static List<AchievementModel> achievement = [];

  @override
  Stream<List<ImageModel>> getImages(bool isCompleted) {
    final images = isar.imageModels
        .filter()
        // .isCompletedIsNotNull()
        .isCompletedEqualTo(isCompleted)
        .build();

    return images.watch(fireImmediately: true);
  }

  @override
  Future<List<AchievementModel>> getAllAchievements() async {
    if (achievement.isNotEmpty) return achievement;

    final response = await ApiProvider.shared.get(Links.achievementAll);
    if (response.data == null) throw Exception('No achievements data!');

    final parsedList = (response.data as List)
        .map((e) => AchievementModel.fromJson(e))
        .toList();

    achievement.addAll(parsedList.where((e) => e.enabled == true));
    return achievement;
  }

  @override
  Future<List<AchievementProgressModel>> getAchievementsProgresses() async {
    final userId = await SharedPrefManager.shared.get(C.lastUserId);
    if (userId is! int) return [];
    final response = await ApiProvider.shared
        .get('${Links.achievementProgressAll}?value=${userId.toString()}');
    if (response.data == null) throw Exception('No achievements data!');

    final parsedList = (response.data as List)
        .map((e) => AchievementProgressModel.fromJson(e))
        .toList();

    return parsedList;
  }
}
