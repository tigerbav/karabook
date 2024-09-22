import 'package:either_dart/either.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/pages/game/data/datasources/game_datasource.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IGameRepository {
  Future<Either<Failure, void>> updateImage(ImageModel image);
  Future<Either<Failure, List<int>>> getProgress(int id);
  Future<Either<Failure, void>> updateServer(Progress progress);
}

class GameRepository extends IGameRepository {
  GameRepository(this._dataSource);
  final IGameDataSource _dataSource;

  @override
  Future<Either<Failure, void>> updateImage(
    ImageModel image,
  ) async {
    try {
      await _dataSource.updateImage(image);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getProgress(int id) async {
    try {
      final result = await _dataSource.getProgress(id);
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, void>> updateServer(Progress progress) async {
    try {
      await _dataSource.updateServer(progress);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
