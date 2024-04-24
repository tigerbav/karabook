import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:karabookapp/pages/contact_us/data/datasources/contact_us_datasource.dart';
import 'package:karabookapp/services/network/failures/failure.dart';

abstract class IContactUsRepository {
  Future<Either<Failure, void>> sendEmail({
    required String message,
    required List<File> files,
  });
}

class ContactUsRepository extends IContactUsRepository {
  final IContactUsDataSource _dataSource;

  ContactUsRepository(this._dataSource);

  @override
  Future<Either<Failure, void>> sendEmail({
    required String message,
    required List<File> files,
  }) async {
    try {
      await _dataSource.sendMessage(message, files);
      return const Right({});
    } catch (e, trace) {
      return Left(Failure.from(e, trace));
    }
  }
}
