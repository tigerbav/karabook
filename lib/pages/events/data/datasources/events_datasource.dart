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
    final images = await DBProvider.db.getCategoryNameAndSub('Daily');
    final swappedImages = <SvgImage>[];
    for (final image in images) {
      swappedImages.insert(0, image);
    }

    return swappedImages;
  }

  @override
  Future<List<SvgImage>> getComics() async {
    await Future.delayed(const Duration(seconds: 1));

    return await DBProvider.db.getCategoryNameAndSub('Comics');
  }
}
