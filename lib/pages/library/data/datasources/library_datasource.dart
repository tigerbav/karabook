import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class ILibraryDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<CategoryModel>> getVipCategories();
  Future<List<ImageModel>> getImagesByPage({
    required int currPage,
    required int categoryId,
  });
  Future<List<ImageModel>> getAllImagesFromPack(int packId);
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
    final freeCategory =
        categories.where((e) => e.enabled && e.categoryTypeId == 0).toList();
    late final vip = CategoryModel(id: C.vipID)..name = C.vip;
    return [
      ...freeCategory,
      if (categories.firstWhereOrNull((e) => e.categoryTypeId == 2) != null)
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
    required int currPage,
    required int categoryId,
  }) async {
    if (ImageManager.modifiedDates.isEmpty) {
      final response = await ApiProvider.shared.get(Links.modifiedImage);

      ImageManager.modifiedDates.addAll(
        (response.data as List).map((e) => ImageModel.fromJson(e)).toList(),
      );
    }
    final modifiedDates = ImageManager.modifiedDates
        .where((e) => e.categoryId == categoryId)
        .toList();

    // get data from ISAR
    var isarImages = <ImageModel>[];

    try {
      final models = await isar.imageModels
          .filter()
          .categoryIdEqualTo(categoryId)
          .isDailyEqualTo(false)
          .offset(C.imageOnPage * currPage)
          .limit(C.imageOnPage)
          .findAll();

      isarImages.addAll(models);
    } catch (e) {
      debugPrint('ISAR: ${isar.imageModels.name} get error - $e.');
    }

    // compare local and global DB. Differences are in [ids]
    final ids = <int>[];
    for (final image in isarImages) {
      final imageModel =
          modifiedDates.firstWhereOrNull((e) => e.id == image.id);
      if (imageModel == null) {
        ids.add(image.id);
        continue;
      }

      if (imageModel.modifiedDate != image.modifiedDate) ids.add(image.id);
    }

    // some images can be old, we should to delete them from ISAR
    final isarImgSet = isarImages.map((e) => e.id).toSet();
    final modifiedDataSet = modifiedDates.map((e) => e.id).toSet();
    final deletedIds = isarImgSet.difference(modifiedDataSet);
    if (deletedIds.isNotEmpty) {
      IsarService.shared.deleteObjects(
        ids: deletedIds.toList(),
        from: isar.imageModels,
      );
    }
    isarImages = isarImages
        .where((i) => deletedIds.firstWhereOrNull((e) => e == i.id) == null)
        .toList();

    // some ids which were deleted from server can be in [ids]
    final requiredIds = <int>[];
    for (final id in ids) {
      if (deletedIds.contains(id) == false) requiredIds.add(id);
    }

    // when isarImages.length is less then [C.imageOnPage] it means, that it is
    // last page. So, we need to be sure, that there are no new images from server
    if (isarImages.length < C.imageOnPage) {
      final allImgs = await IsarService.shared.getObjects(
        from: isar.imageModels,
      );
      final isarImgSet = allImgs
          .where((e) => e.categoryId == categoryId)
          .map((e) => e.id)
          .toSet();
      final newIds = modifiedDataSet.difference(isarImgSet);
      if (newIds.isNotEmpty) requiredIds.addAll(newIds);
    }

    if (requiredIds.isEmpty) return isarImages;

    // get updated images
    final responseForUpd = await ApiProvider.shared.get(
      '${Links.imageByIds}?value=${requiredIds.join(',')}',
    );

    final parseUpdImages = (responseForUpd.data as List)
        .map((e) => ImageModel.fromJson(e))
        .toList();

    // update ISAR
    for (final image in parseUpdImages) {
      IsarService.shared.writeSync(
        object: image,
        to: isar.imageModels,
      );
    }
    isarImages.addAll(parseUpdImages);

    return isarImages;
  }

  @override
  Future<List<ImageModel>> getAllImagesFromPack(int packId) async {
    if (ImageManager.modifiedDates.isEmpty) {
      final response = await ApiProvider.shared.get(Links.modifiedImage);

      ImageManager.modifiedDates.addAll(
        (response.data as List).map((e) => ImageModel.fromJson(e)).toList(),
      );
    }
    final modifiedDates = ImageManager.modifiedDates
        .where((e) => e.categoryId == packId)
        .toList();

    // get data from ISAR
    var isarImages = <ImageModel>[];

    try {
      final models =
          await isar.imageModels.filter().categoryIdEqualTo(packId).findAll();

      isarImages.addAll(models);
    } catch (e) {
      debugPrint('ISAR: ${isar.imageModels.name} get error - $e.');
    }

    // compare local and global DB. Differences are in [ids]
    final ids = <int>[];
    for (final image in isarImages) {
      final imageModel =
          modifiedDates.firstWhereOrNull((e) => e.id == image.id);
      if (imageModel == null) {
        ids.add(image.id);
        continue;
      }

      if (imageModel.modifiedDate != image.modifiedDate) ids.add(image.id);
    }

    // some images can be old, we should to delete them from ISAR
    final isarImgSet = isarImages.map((e) => e.id).toSet();
    final modifiedDataSet = modifiedDates.map((e) => e.id).toSet();
    final deletedIds = isarImgSet.difference(modifiedDataSet);
    if (deletedIds.isNotEmpty) {
      IsarService.shared.deleteObjects(
        ids: deletedIds.toList(),
        from: isar.imageModels,
      );
    }
    isarImages = isarImages
        .where((i) => deletedIds.firstWhereOrNull((e) => e == i.id) == null)
        .toList();

    // some ids which were deleted from server can be in [ids]
    final requiredIds = <int>[];
    for (final id in ids) {
      if (deletedIds.contains(id) == false) requiredIds.add(id);
    }

    // when isarImages.length is less then [C.imageOnPage] it means, that it is
    // last page. So, we need to be sure, that there are no new images from server
    if (isarImages.length < C.imageOnPage) {
      final allImgs = await IsarService.shared.getObjects(
        from: isar.imageModels,
      );
      final isarImgSet =
          allImgs.where((e) => e.categoryId == packId).map((e) => e.id).toSet();
      final newIds = modifiedDataSet.difference(isarImgSet);
      if (newIds.isNotEmpty) requiredIds.addAll(newIds);
    }

    if (requiredIds.isEmpty) return isarImages;

    // get updated images
    final responseForUpd = await ApiProvider.shared.get(
      '${Links.imageByIds}?value=${requiredIds.join(',')}',
    );

    final parseUpdImages = (responseForUpd.data as List)
        .map((e) => ImageModel.fromJson(e))
        .toList();

    // update ISAR
    for (final image in parseUpdImages) {
      IsarService.shared.writeSync(
        object: image,
        to: isar.imageModels,
      );
    }
    isarImages.addAll(parseUpdImages);

    return isarImages;
  }
}
