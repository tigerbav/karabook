import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_category.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

abstract class ILibraryDataSource {
  Future<List<ImageCategory?>> getAllCategories();
  Future<List<SvgImage?>> getAllImages();
  // Future<List<Pack?>> getAllPacks();
  Future<List<SvgImage?>> getAllImagesFromPack(String packName);
}

class LibraryDataSource extends ILibraryDataSource {
  @override
  Future<List<ImageCategory?>> getAllCategories() async {
    return [];
  }

  @override
  Future<List<SvgImage?>> getAllImages() async {
    final images = await IsarService.shared.getObjects(from: isar.svgImages);

    return images;
  }

  // @override
  // Future<List<Pack?>> getAllPacks() async {
  //   return [];
  // }

  @override
  Future<List<SvgImage?>> getAllImagesFromPack(String packName) async {
    return [];
  }
}
