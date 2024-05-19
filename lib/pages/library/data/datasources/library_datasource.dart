import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/services/sqflite/db_provider.dart';

abstract class ILibraryDataSource {
  Future<List<ImageCategory?>> getAllCategories();
  Future<List<SvgImage?>> getAllImages();
  Future<List<Pack?>> getAllPacks();
  Future<List<SvgImage?>> getAllImagesFromPack(String packName);
  //Future<List<SvgImage?>> getAllImagesFromCategory(int categoryId);
}

class LibraryDataSource extends ILibraryDataSource {
  @override
  Future<List<ImageCategory?>> getAllCategories() async {
    return await DBProvider.db.getImageCategory();
  }

  @override
  Future<List<SvgImage?>> getAllImages() async {
    return await DBProvider.db.getAllImages();
  }

  @override
  Future<List<Pack?>> getAllPacks() async {
    return await DBProvider.db.getPacks();
  }



  @override
  Future<List<SvgImage?>> getAllImagesFromPack(String packName) async {
    return await DBProvider.db.getPacksColoringVIP(packName);
  }

  // @override
  // Future<List<SvgImage?>> getAllImagesFromCategory(int categoryId) {
  //   return await DBProvider.db.
  //   // TODO: implement getAllImagesFromCategory
  //   throw UnimplementedError();
  // }
}
