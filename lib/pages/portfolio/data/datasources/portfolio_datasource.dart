import 'dart:async';

import 'package:isar/isar.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

abstract class IPortfolioDataSources {
  Stream<List<ImageModel>> getImages(bool isCompleted);
}

class PortfolioDataSources extends IPortfolioDataSources {
  @override
  Stream<List<ImageModel>> getImages(bool isCompleted) {
    final images = isar.imageModels
        .filter()
        // .isCompletedIsNotNull()
        .isCompletedEqualTo(isCompleted)
        .build();

    return images.watch(fireImmediately: true);
  }
}
