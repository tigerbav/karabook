import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IPortfolioRepository {
  Future<Either<Failure, List<ImageModel>>> getCurrentImages();
  Future<Either<Failure, List<ImageModel>>> getCompletedImages();
}

class PortfolioRepository extends IPortfolioRepository {
  PortfolioRepository(this._dataSources);
  final IPortfolioDataSources _dataSources;

  @override
  Future<Either<Failure, List<ImageModel>>> getCompletedImages() async {
    try {
      final result = await _dataSources.getImages(true);
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getCurrentImages() async {
    try {
      final result = await _dataSources.getImages(false);
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
