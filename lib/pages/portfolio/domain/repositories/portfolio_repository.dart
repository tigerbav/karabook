import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IPortfolioRepository {
  Future<Either<Failure, List<SvgImage>>> getCurrentImages();
  Future<Either<Failure, List<SvgImage>>> getCompletedImages();
}

class PortfolioRepository extends IPortfolioRepository {
  PortfolioRepository(this._dataSources);
  final IPortfolioDataSources _dataSources;

  @override
  Future<Either<Failure, List<SvgImage>>> getCompletedImages() async {
    try {
      final result = await _dataSources.getCompletedImages();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<SvgImage>>> getCurrentImages() async {
    try {
      final result = await _dataSources.getCurrentImages();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
