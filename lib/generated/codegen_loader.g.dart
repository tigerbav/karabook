// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "something_went_wrong": "Something went wrong.",
  "please_select_a_color": "Please, select a color from the panel below.",
  "congratulations_mission_completed": "Congratulations! Mission completed!",
  "no_categories": "No categories.",
  "no_images": "No images.",
  "get_this_comic": "Get this comic",
  "daily": "Daily",
  "comics": "Comics",
  "soon": "Soon...",
  "in_progress": "In progress",
  "completed": "Completed"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US};
}
