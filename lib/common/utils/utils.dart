import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static FToast showToast(
    BuildContext context,
    String? text, {
    Icon? icon,
    bool isError = true,
  }) {
    final redBg = isError || text == null;

    return FToast()
      ..init(context)
      ..showToast(
        gravity: redBg ? ToastGravity.BOTTOM : ToastGravity.TOP,
        toastDuration: const Duration(seconds: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: redBg ? AppColors.shared.red : AppColors.shared.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) icon,
              const SizedBox(width: 12),
              Text(
                text ?? LocaleKeys.something_went_wrong.tr(),
                style:
                    isError ? AppStyles.shared.segment : AppStyles.shared.toast,
              ),
            ],
          ),
        ),
      );
  }

  static Future<void> launchURL(String? url) async {
    if (url == null) return;
    await launchUrlString(url);
  }

  static showPopUp(
    BuildContext context,
    Widget widget,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.shared.popupBg,
      builder: (_) => Dialog(
        elevation: 0,
        child: widget,
      ),
    );
  }
}
