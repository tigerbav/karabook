import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:karabookapp/services/isar/models/achievement_model.dart';
import 'package:karabookapp/services/isar/models/achievement_progress_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IPortfolioRepository {
  Stream<List<ImageModel>>? getCurrentImages();
  Stream<List<ImageModel>>? getCompletedImages();
  Future<Either<Failure, List<AchievementModel>>> getAllAchievements();
  Future<Either<Failure, List<AchievementProgressModel>>>
      getAchievementsProgresses();
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

  @override
  Future<Either<Failure, List<AchievementModel>>> getAllAchievements() async {
    try {
      final result = await _dataSources.getAllAchievements();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<AchievementProgressModel>>>
      getAchievementsProgresses() async {
    try {
      final result = await _dataSources.getAchievementsProgresses();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
