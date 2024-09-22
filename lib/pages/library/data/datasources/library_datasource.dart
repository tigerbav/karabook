import 'dart:math';

import 'package:isar/isar.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';

abstract class ILibraryDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<CategoryModel>> getVipCategories();
  Future<List<ImageModel>> getImagesByPage({
    required int categoryId,
    required List<int> displayIds,
  });
  Future<List<ImageModel>> getAllImagesFromPack({
    required int packId,
    required List<int> displayIds,
  });
  Future<List<CategoryModel>> getBanners();
}

class LibraryDataSource extends ILibraryDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final categories = await IsarService.shared.getObjects(
      from: isar.categoryModels,
    );
    categories.sort((c1, c2) {
      if (c1.sort == c2.sort) return 0; //for null
      if (c1.sort == null) return 1;
      if (c2.sort == null) return -1;

      return c1.sort!.compareTo(c2.sort!);
    });
    final freeCategory = categories
        .where((e) => e.enabled && e.categoryTypeId == C.categoryTypeId)
        .toList();
    late final vip = CategoryModel(id: C.vipID)..name = C.vip;
    return [
      ...freeCategory,
      if (categories
              .firstWhereOrNull((e) => e.categoryTypeId == C.paidPackTypeId) !=
          null)
        vip,
    ];
  }

  @override
  Future<List<CategoryModel>> getVipCategories() async {
    final categories =
        await isar.categoryModels.filter().categoryTypeIdEqualTo(2).findAll();
    categories.sort((c1, c2) {
      if (c1.sort == c2.sort) return 0; //for null
      if (c1.sort == null) return 1;
      if (c2.sort == null) return -1;

      return c1.sort!.compareTo(c2.sort!);
    });
    return categories;
  }

  @override
  Future<List<ImageModel>> getImagesByPage({
    required int categoryId,
    required List<int> displayIds,
  }) async {
    return await ImageManager.shared.getImages(
      imageType: ImageType.byCategory,
      categoryId: categoryId,
      displayIds: displayIds,
    );
  }

  @override
  Future<List<ImageModel>> getAllImagesFromPack({
    required int packId,
    required List<int> displayIds,
  }) async {
    return await ImageManager.shared.getImages(
      imageType: ImageType.paidComics,
      categoryId: packId,
      displayIds: displayIds,
    );
  }

  @override
  Future<List<CategoryModel>> getBanners() async {
    final models =
        await IsarService.shared.getObjects(from: isar.categoryModels);

    final packs = models
        .where((e) =>
            e.categoryTypeId == C.paidPackTypeId ||
            e.categoryTypeId == C.packTypeId)
        .toList();

    return packs.sublist(max(packs.length - C.maxBanners, 0)).reversed.toList();
  }
}
