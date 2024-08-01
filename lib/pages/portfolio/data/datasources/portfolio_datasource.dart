import 'dart:async';

import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

abstract class IPortfolioDataSources {
  Future<List<ImageModel>> getImages(bool isCompleted);
}

class PortfolioDataSources extends IPortfolioDataSources {
  @override
  Future<List<ImageModel>> getImages(bool isCompleted) async {
    final images = await IsarService.shared.getObjects(
      from: isar.imageModels,
    );
    final painterProgress = await IsarService.shared.getObjects(
      from: isar.painterProgress,
    );
    final ids = painterProgress
        .where((e) => e.isCompleted == isCompleted)
        .map((e) => e.id)
        .toList();
    final completedImages = images
        .where((e) => ids.firstWhereOrNull((id) => id == e.id) != null)
        .toList();

    return completedImages;
  }
}
