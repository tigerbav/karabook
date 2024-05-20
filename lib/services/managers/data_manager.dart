import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

class DataManager {
  static DataManager shared = DataManager._();
  DataManager._();

  Future<void> getAllImages() async {
    final images = await ApiProvider.shared.get(Links.imageGetAll);

    final parsedImages =
        (images.data as List).map((e) => SvgImage.fromJson(e)).toList();

    IsarService.shared.clearAndWriteAllSync(
      collection: isar.svgImages,
      list: parsedImages,
    );
  }
}
