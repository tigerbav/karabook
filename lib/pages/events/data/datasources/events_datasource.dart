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

abstract class IEventsDataSource {
  Future<List<ImageModel>> getDailyImages();
  Future<Map<CategoryModel, List<ImageModel>>> getComics();
}

class EventsDataSource extends IEventsDataSource {
  EventsDataSource();

  @override
  Future<List<ImageModel>> getDailyImages() async {
    if (ImageManager.modifiedDates.isEmpty) {
      final response = await ApiProvider.shared.get(Links.modifiedImage);

      ImageManager.modifiedDates.addAll(
        (response.data as List).map((e) => ImageModel.fromJson(e)).toList(),
      );
    }
    var modifiedDates =
        ImageManager.modifiedDates.where((e) => e.isDaily == true);
    modifiedDates = modifiedDates.take(C.imageForDaily).toList();

    // get data from ISAR
    var isarImages = <ImageModel>[];
    try {
      final models =
          await isar.imageModels.filter().isDailyEqualTo(true).findAll();

      isarImages.addAll(models);
    } catch (e) {
      debugPrint('ISAR: ${isar.imageModels.name} get error - $e.');
    }

    // compare local and global DB. Differences are in [ids]
    final ids = <int>[];
    for (final image in modifiedDates) {
      final imageModel = isarImages.firstWhereOrNull((e) => e.id == image.id);
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
    var requiredIds = <int>[];
    for (final id in ids) {
      if (deletedIds.contains(id) == false) requiredIds.add(id);
    }

    // when isarImages.length is less then [C.imageOnPage] it means, that it is
    // last page. So, we need to be sure, that there are no new images from server
    if (isarImages.length < C.imageForDaily) {
      final allImgs = await IsarService.shared.getObjects(
        from: isar.imageModels,
      );
      final isarImgSet =
          allImgs.where((e) => e.isDaily == true).map((e) => e.id).toSet();
      final newIds = modifiedDataSet.difference(isarImgSet);
      if (newIds.isNotEmpty) requiredIds.addAll(newIds);
    }

    requiredIds = requiredIds.toSet().toList();
    if (requiredIds.isEmpty) return isarImages.reversed.toList();

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

    return isarImages.reversed.toList();
  }

  @override
  Future<Map<CategoryModel, List<ImageModel>>> getComics() async {
    var comicsCategories = await IsarService.shared.getObjects(
      from: isar.categoryModels,
    );
    comicsCategories =
        comicsCategories.where((e) => e.categoryTypeId == 1).toList();

    final map = <CategoryModel, List<ImageModel>>{};

    for (final category in comicsCategories) {
      final list = await _getComicsList(category.id);
      list.sort((a, b) => a.sort.compareTo(b.sort));
      map[category] = list;
    }

    return map;
  }

  Future<List<ImageModel>> _getComicsList(int categoryId) async {
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
          .findAll();

      isarImages.addAll(models);
    } catch (e) {
      debugPrint('ISAR: ${isar.imageModels.name} get error - $e.');
    }

    // compare local and global DB. Differences are in [ids]
    final ids = <int>[];
    for (final image in modifiedDates) {
      final imageModel = isarImages.firstWhereOrNull((e) => e.id == image.id);
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
    var requiredIds = <int>[];
    for (final id in ids) {
      if (deletedIds.contains(id) == false) requiredIds.add(id);
    }

    if (isarImages.isEmpty) {
      requiredIds.addAll(modifiedDates.map((e) => e.id).toList());
    }

    requiredIds = requiredIds.toSet().toList();
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
