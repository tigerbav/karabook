import 'package:karabookapp/services/isar/models/svg_image.dart';

abstract class IPortfolioDataSources {
  Future<List<SvgImage>> getCurrentImages();
  Future<List<SvgImage>> getCompletedImages();
}

class PortfolioDataSources extends IPortfolioDataSources {
  @override
  Future<List<SvgImage>> getCompletedImages() async {
    return [];
  }

  @override
  Future<List<SvgImage>> getCurrentImages() async {
    return [];
  }
}
