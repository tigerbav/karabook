import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/image_manager.dart';

abstract class IEventsDataSource {
  Future<List<ImageModel>> getDailyImages();
  Future<Map<CategoryModel, List<ImageModel>>> getAllComics();
  Future<List<ImageModel>> getComicsList({
    required int categoryId,
    required List<int> displayIds,
  });
}

class EventsDataSource extends IEventsDataSource {
  EventsDataSource();

  @override
  Future<List<ImageModel>> getDailyImages() async {
    return await ImageManager.shared.getImages(
      imageType: ImageType.daily,
      categoryId: 0,
      displayIds: [],
    );
  }

  @override
  Future<Map<CategoryModel, List<ImageModel>>> getAllComics() async {
    var comicsCategories = await IsarService.shared.getObjects(
      from: isar.categoryModels,
    );
    comicsCategories =
        comicsCategories.where((e) => e.categoryTypeId == 1).toList();

    final map = <CategoryModel, List<ImageModel>>{};

    for (final category in comicsCategories) {
      final list = await getComicsList(categoryId: category.id, displayIds: []);
      list.sort((a, b) => a.sort.compareTo(b.sort));
      map[category] = list;
    }

    return map;
  }

  @override
  Future<List<ImageModel>> getComicsList({
    required int categoryId,
    required List<int> displayIds,
  }) async {
    return await ImageManager.shared.getImages(
      imageType: ImageType.freeComics,
      categoryId: categoryId,
      displayIds: displayIds,
    );
  }
}
