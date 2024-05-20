import 'package:karabookapp/services/isar/models/svg_image.dart';

abstract class IEventsDataSource {
  Future<List<SvgImage>> getDailyImages();
  Future<List<SvgImage>> getComics();
}

class EventsDataSource extends IEventsDataSource {
  EventsDataSource();

  @override
  Future<List<SvgImage>> getDailyImages() async {
    return [];
  }

  @override
  Future<List<SvgImage>> getComics() async {
    return [];
  }
}
