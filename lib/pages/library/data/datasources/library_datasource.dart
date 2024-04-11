import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/services/sqflite/db_provider.dart';

abstract class ILibraryDataSource {
  Future<List<ImageCategory?>> getAllCategories();
  Future<List<SvgImage?>> getAllImages();
  Future<List<SvgImage>> getImagesByCategoryId();
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
  Future<List<SvgImage>> getImagesByCategoryId() {
    // TODO: implement getImagesByCategoryId
    throw UnimplementedError();
  }
}
