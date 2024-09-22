import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

abstract class IPortfolioRepository {
  Stream<List<ImageModel>>? getCurrentImages();
  Stream<List<ImageModel>>? getCompletedImages();
}

class PortfolioRepository extends IPortfolioRepository {
  PortfolioRepository(this._dataSources);
  final IPortfolioDataSources _dataSources;

  @override
  Stream<List<ImageModel>>? getCompletedImages() {
    try {
      return _dataSources.getImages(true);
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<List<ImageModel>>? getCurrentImages() {
    try {
      return _dataSources.getImages(false);
    } catch (_) {
      return null;
    }
  }
}
