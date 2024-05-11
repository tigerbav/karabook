import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/game_screen/data/datasources/game_datasource.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IGameRepository {
  Future<Either<Failure, void>> updateImage(PainterProgress painterProgress);
  Future<Either<Failure, List<int>>> getProgress(int id);
}

class GameRepository extends IGameRepository {
  GameRepository(this._dataSource);
  final IGameDataSource _dataSource;

  @override
  Future<Either<Failure, void>> updateImage(
    PainterProgress painterProgress,
  ) async {
    try {
      await _dataSource.updateImage(painterProgress);
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
}
