import 'package:either_dart/either.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class ILibraryRepository {
  Future<Either<Failure, List<ImageCategory>>> getAllCategories();
  Future<Either<Failure, List<SvgImage>>> getAllImages();
}

class LibraryRepository extends ILibraryRepository {
  LibraryRepository(this._dataSource);
  final ILibraryDataSource _dataSource;

  @override
  Future<Either<Failure, List<ImageCategory>>> getAllCategories() async {
    try {
      final result = await _dataSource.getAllCategories();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, List<SvgImage>>> getAllImages() async {
    try {
      final result = await _dataSource.getAllImages();
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
