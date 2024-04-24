import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/pages/portfolio/data/models/achievement.dart';

import '../sqflite/db_provider.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  ApiProvider._();
  static final shared = ApiProvider._();

  static const _token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJKV1QgU2lnbiBBZG1pbiIsImlhdCI6MTcxMjEzMTIxNSwiZXhwIjoxNzQzNjY3MjY3LCJhdWQiOiJrYXJhYm9vay5jb20iLCJzdWIiOiJuby1yZXBseUBrYXJhYm9vay5jb20iLCJHaXZlbk5hbWUiOiJBbmRyaWkiLCJTdXJuYW1lIjoiWmRyb2J5bGtvIiwiRW1haWwiOiJuby1yZXBseUBrYXJhYm9vay5jb20iLCJSb2xlIjoiRGV2ZWxvcGVyIn0.TzcJ9_DCuA3f1RI_0D1RDg4EhBJmbo3Ys6VEpy5GGUM';

  static final _options = Options(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token",
    },
  );

  static const _baseUrl = 'http://185.65.244.209:8089/';

  Future<List<ImageCategory?>> getAllImageCategory() async {
    var url = "${_baseUrl}image-category/";

    final response = await Dio().get(url, options: _options);

    return (response.data as List).map((imageCategory) {
      final fromJson = ImageCategory.fromJson(imageCategory);
      DBProvider.db.createImageCategory(fromJson);

      return fromJson;
    }).toList();
  }

  Future<List<SvgImage?>> getAllSvgImage() async {
    var url = "${_baseUrl}svg-image/";
    Response response = await Dio().get(url, options: _options);

    return (response.data as List).map((svgImage) {
      final fromJson = SvgImage.fromJsonApi(svgImage);
      DBProvider.db.createSvgImage(fromJson);

      return fromJson;
    }).toList();
  }

  Future<List<Pack?>> getAllPacks() async {
    var url = "${_baseUrl}packs";
    Response response = await Dio().get(url);

    return (response.data as List).map((packs) {
      final fromJson = Pack.fromJson(packs);
      DBProvider.db.createPacks(fromJson);

      return fromJson;
    }).toList();
  }

  Future<List<Achievement?>> createAchievementsProgress() async {
    return (C.achievementsLocalData).map((achievementsLocalData) {
      DBProvider.db.createAchievementsProgress(
        Achievement.fromJson(achievementsLocalData.toJson()),
      );
    }).toList();
  }
}
