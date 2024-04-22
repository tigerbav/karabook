import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/services/sqflite/db_provider.dart';

abstract class IEventsDataSource {
  Future<List<SvgImage>> getDailyImages();
  Future<List<SvgImage>> getComics();
}

class EventsDataSource extends IEventsDataSource {
  EventsDataSource();

  @override
  Future<List<SvgImage>> getDailyImages() async {
    return await DBProvider.db.getCategoryNameAndSub('Daily');
  }

  @override
  Future<List<SvgImage>> getComics() async {
    await Future.delayed(const Duration(seconds: 1));

    return await DBProvider.db.getCategoryNameAndSub('Comics');
  }
}
