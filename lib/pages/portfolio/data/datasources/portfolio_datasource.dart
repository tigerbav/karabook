import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/services/sqflite/db_provider.dart';

abstract class IPortfolioDataSources {
  Future<List<SvgImage>> getCurrentImages();
  Future<List<SvgImage>> getCompletedImages();
}

class PortfolioDataSources extends IPortfolioDataSources {
  @override
  Future<List<SvgImage>> getCompletedImages() async {
    return await DBProvider.db.getSvgImageInProgress(1);
  }

  @override
  Future<List<SvgImage>> getCurrentImages() async {
    return await DBProvider.db.getSvgImageInProgress(0);
  }
}
