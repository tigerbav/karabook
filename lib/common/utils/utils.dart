import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class Utils {
  //Icon(Icons.check), LocaleKeys.please_select_a_color.tr(),
  // Icon(Icons.arrow_drop_down_circle_outlined),LocaleKeys.congratulations_mission_completed.tr(),
  static FToast showToast(
    BuildContext context,
    String? text, [
    Icon? icon,
    bool isError = true,
  ]) {
    final redBg = isError || text == null;

    return FToast()
      ..init(context)
      ..showToast(
        gravity: redBg ? ToastGravity.BOTTOM : ToastGravity.TOP,
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
                style: AppStyles.shared.toast,
              ),
            ],
          ),
        ),
      );
  }
}
