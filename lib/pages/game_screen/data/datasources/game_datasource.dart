import 'package:flutter/material.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class IGameDataSource {
  Future<void> updateImage(PainterProgress painterProgress);
  Future<List<int>> getProgress(int id);
  Future<void> updateServer(Progress progress);
}

class GameDataSource extends IGameDataSource {
  final ApiProvider _apiProvider;
  GameDataSource() : _apiProvider = ApiProvider.shared;
  @override
  Future<void> updateImage(PainterProgress painterProgress) async {
    await IsarService.shared.writeSync<PainterProgress>(
      object: painterProgress,
      to: isar.painterProgress,
    );
  }

  @override
  Future<List<int>> getProgress(int id) async {
    final result = await IsarService.shared.getObject(
      from: isar.painterProgress,
      id: id,
    );
    if (result == null || result.completedIds == null) return [];

    return result.completedIds!;
  }

  @override
  Future<void> updateServer(Progress progress) async {
    try {
      await _apiProvider.delete(
        '${Links.deleteByUserAndImage}?userId=${progress.userId}&imageId=${progress.imageId}',
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Can\'t update progress on server');
    }
    try {
      await _apiProvider.post(Links.progressAdd, progress.toJson());
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Can\'t update progress on server');
    }
  }
}
