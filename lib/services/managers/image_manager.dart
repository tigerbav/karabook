import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

class ImageManager {
  static final _modifiedDates = <ImageModel>[];
  static ImageManager shared = ImageManager._();
  ImageManager._();

  Future<List<ImageModel>> get _getModifiedDates async {
    if (ImageManager._modifiedDates.isEmpty) {
      await _updateModifiedDates();
    }

    return _modifiedDates;
  }

  Future<void> _updateModifiedDates() async {
    final response = await ApiProvider.shared.get(Links.modifiedImage);

    _modifiedDates.addAll(
      (response.data as List).map((e) => ImageModel.fromJson(e)).toList(),
    );
  }

  Future<ImageModel?> getImageById(int id) async {
    return await IsarService.shared.getObject(from: isar.imageModels, id: id);
  }

  Future<List<ImageModel>> getImages({
    required ImageType imageType,
    required int categoryId,
    required List<int> displayIds,
  }) async {
    // get data from ISAR
    var isarImages = <ImageModel>[];

    final models = await imageType.getFromIsar(
      categoryId: categoryId,
      lastIndex: displayIds.length,
    );

    isarImages.addAll(models);

    List<ImageModel> modifiedDates;

    try {
      modifiedDates = (await _getModifiedDates).where((e) {
        if (ImageType.daily == imageType) return e.isDaily;

        return e.categoryId == categoryId && e.isDaily == false;
      }).toList();
    } catch (_) {
      return models;
    }

    // compare local and global DB. Differences are in [ids]
    final ids = <int>[];
    for (final image in modifiedDates) {
      if (displayIds.contains(image.id)) continue;

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

    final parseUpdImages = (responseForUpd.data as List).map((e) {
      final parsed = ImageModel.fromJson(e);
      final image = isarImages.firstWhereOrNull((e) => e.id == parsed.id);
      if (image == null) return parsed;

      isarImages.remove(image);
      return parsed.copyWith(
        isCompleted: image.isCompleted,
        completedIds: image.completedIds,
        screenProgress: image.screenProgress,
      );
    }).toList();

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
