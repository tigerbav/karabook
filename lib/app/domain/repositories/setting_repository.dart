import 'package:either_dart/either.dart';
import 'package:karabookapp/app/data/datasources/setting_datasource.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class ISettingRepository {
  Future<Either<Failure, int?>> getUser(String email);
  Future<Either<Failure, void>> deleteAccount(int userId);
  Future<Either<Failure, void>> updateProgress(int userId);
}

class SettingRepository extends ISettingRepository {
  final ISettingDataSource _dataSource;
  SettingRepository(this._dataSource);

  @override
  Future<Either<Failure, int?>> getUser(String email) async {
    try {
      final result = await _dataSource.getUser(email);
      if (result != null) {
        await SharedPrefManager.shared.write(C.lastUserId, result);
      }
      return Right(result);
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(int userId) async {
    try {
      await _dataSource.deleteAccount(userId);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }

  @override
  Future<Either<Failure, void>> updateProgress(int userId) async {
    try {
      await _dataSource.updateProgress(userId);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
