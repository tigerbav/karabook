import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class AppPopup extends StatelessWidget {
  const AppPopup({
    super.key,
    required this.description,
    this.onTapYes,
    this.justDescription = false,
    this.extraWidget,
  });

  final String description;
  final VoidCallback? onTapYes;
  final bool justDescription;
  final Widget? extraWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.sp),
        color: AppColors.shared.white,
      ),
      padding: EdgeInsets.all(20.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            description,
            style: AppStyles.shared.settingsOption,
          ),
          SizedBox(height: 20.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (justDescription == false) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: context.router.maybePop,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.shared.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                      ),
                      padding: EdgeInsets.all(10.sp),
                      child: Text(
                        LocaleKeys.no.tr(),
                        textAlign: TextAlign.center,
                        style: AppStyles.shared.btnBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.sp),
              ],
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTapYes?.call();
                    context.router.maybePop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.shared.darkPurple,
                      borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                    ),
                    padding: EdgeInsets.all(10.sp),
                    child: Text(
                      justDescription
                          ? LocaleKeys.ok.tr().toUpperCase()
                          : LocaleKeys.yes.tr(),
                      textAlign: TextAlign.center,
                      style: AppStyles.shared.btn,
                    ),
                  ),
                ),
              )
            ],
          ),
          if (extraWidget != null) ...[
            SizedBox(height: 10.sp),
            Center(child: extraWidget!),
          ],
        ],
      ),
    );
  }
}
