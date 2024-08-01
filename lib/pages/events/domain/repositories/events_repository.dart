import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/events/data/datasources/events_datasource.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IEventsRepository {
  Future<Either<Failure, List<ImageModel>>> getDailyImages();
  Future<Either<Failure, Map<CategoryModel, List<ImageModel>>>> getComics();
}

class EventsRepository extends IEventsRepository {
  EventsRepository(this._dataSource);
  final IEventsDataSource _dataSource;

  @override
  Future<Either<Failure, List<ImageModel>>> getDailyImages() async {
    try {
      final result = await _dataSource.getDailyImages();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, Map<CategoryModel, List<ImageModel>>>>
      getComics() async {
    try {
      final result = await _dataSource.getComics();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
