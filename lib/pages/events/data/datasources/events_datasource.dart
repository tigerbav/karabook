import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';

abstract class IEventsDataSource {
  Future<List<SvgImage>> getDailyImages();
  Future<List<Pack>> getComics();
}

class EventsDataSource extends IEventsDataSource {
  EventsDataSource();

  @override
  Future<List<SvgImage>> getDailyImages() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const SvgImage(
        id: 0,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 1,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Flowers',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 2,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Exclusive Art',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 3,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Flowers',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 4,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 5,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Nature',
        imageParts: '',
        subcategories: '',
      ),
      const SvgImage(
        id: 6,
        height: 100,
        width: 100,
        complete: 0,
        imageCategory: 'Animals & Birds',
        imageParts: '',
        subcategories: '',
      ),
    ];
  }

  @override
  Future<List<Pack>> getComics() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      const Pack(
        id: 0,
        packName: '',
        packIcon: '',
        packDescription: '',
        packsIdentifier: '',
      ),
      const Pack(
        id: 1,
        packName: '',
        packIcon: '',
        packDescription: '',
        packsIdentifier: '',
      ),
      const Pack(
        id: 2,
        packName: '',
        packIcon: '',
        packDescription: '',
        packsIdentifier: '',
      ),
    ];
  }
}
