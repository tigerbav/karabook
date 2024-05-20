import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

abstract class IGameDataSource {
  Future<void> updateImage(PainterProgress painterProgress);
  Future<List<int>> getProgress(int id);
}

class GameDataSource extends IGameDataSource {
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
}
