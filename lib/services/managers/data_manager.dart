import 'package:karabookapp/services/isar/data_provider.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/locale_model.dart';
import 'package:karabookapp/services/isar/models/text_model.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

class DataManager {
  static DataManager shared = DataManager._();
  DataManager._();

  Future<void> getAllLocales() async {
    final response = await ApiProvider.shared.get(Links.locale);

    final parsedData =
        (response.data as List).map((e) => LocaleModel.fromJson(e)).toList();

    IsarService.shared.clearAndWriteAllSync(
      collection: isar.localeModels,
      list: parsedData,
    );
  }

  Future<void> getAllTexts() async {
    final response = await ApiProvider.shared.get(
      '${Links.serverTextByLocale}${DataProvider.localeCode}',
    );

    final parsedData =
        (response.data as List).map((e) => TextModel.fromJson(e)).toList();

    IsarService.shared.clearAndWriteAllSync(
      collection: isar.textModels,
      list: parsedData,
    );
  }

  Future<CategoryModel?> getAllCategories() async {
    final response = await ApiProvider.shared.get(Links.categoryGetAll);

    final parsedData =
        (response.data as List).map((e) => CategoryModel.fromJson(e)).toList();

    IsarService.shared.clearAndWriteAllSync(
      collection: isar.categoryModels,
      list: parsedData,
    );

    return parsedData.firstOrNull;
  }
}
