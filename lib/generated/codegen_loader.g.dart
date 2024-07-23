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
  "completed": "Completed",
  "loading": "Loading",
  "no_progress_pictures": "Oops.. No progress pictures!",
  "any_finished_paintings": "It seems you don't have any finished paintings!",
  "settings": "Settings",
  "vibration_on_completion": "Vibration on Completion",
  "animation_to_fill": "Animation to Fill",
  "contact_us": "Contact Us",
  "remove_ads": "Remove Ads",
  "restore_purchases": "Restore Purchases",
  "privacy_policy": "Privacy Policy",
  "term_of_use": "Term of Use",
  "send": "Send",
  "email_sent": "Your email was successfully sent.",
  "oops": "Oops...",
  "sign_in_with_google": "Sign in with Google"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US};
}
