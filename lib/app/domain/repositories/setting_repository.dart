import 'package:either_dart/either.dart';
import 'package:karabookapp/app/data/datasources/setting_datasource.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class ISettingRepository {
  Future<Either<Failure, void>> getUser(String email);
}

class SettingRepository extends ISettingRepository {
  final ISettingDataSource _dataSource;
  SettingRepository(this._dataSource);

  @override
  Future<Either<Failure, void>> getUser(String email) async {
    try {
      await _dataSource.getUser(email);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
