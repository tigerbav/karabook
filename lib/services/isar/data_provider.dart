import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

class DataProvider {
  static final DataProvider shared = DataProvider._();
  DataProvider._() {
    _init();
  }

  _init() async {
    final sharedPrefData = await SharedPrefManager.shared.get(C.locale);
    if (sharedPrefData != null && sharedPrefData is String) {
      localeCode = sharedPrefData;
    }
  }

  static String localeCode = C.defaultLocale;

  Future<List<CategoryModel>> getCategoryModels() async {
    final models =
        await IsarService.shared.getObjects(from: isar.categoryModels);

    return models;
  }
}
