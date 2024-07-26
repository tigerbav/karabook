import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class ILibraryRepository {
  Future<Either<Failure, List<CategoryModel>>> getAllCategories();
  Future<Either<Failure, List<CategoryModel>>> getVipCategories();
  Future<Either<Failure, List<ImageModel>>> getImages({
    required int categoryId,
  });
  Future<Either<Failure, List<ImageModel>>> getAllImagesFromPack(
    int packId,
  );
}

class LibraryRepository extends ILibraryRepository {
  LibraryRepository(this._dataSource);
  final ILibraryDataSource _dataSource;

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final result = await _dataSource.getAllCategories();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getVipCategories() async {
    try {
      final result = await _dataSource.getVipCategories();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getImages({
    required int categoryId,
  }) async {
    try {
      final result = await _dataSource.getImagesByPage(
        categoryId: categoryId,
      );
      return Right(result.where((e) => e.isDaily == false).toList());
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<ImageModel>>> getAllImagesFromPack(
    int packId,
  ) async {
    try {
      final result = await _dataSource.getAllImagesFromPack(packId);
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
