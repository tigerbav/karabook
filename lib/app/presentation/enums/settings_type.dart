import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

enum SettingsType {
  vibration,
  fill,
  contactUs,
  deleteAds,
  restore,
}

extension SettingsTypeEx on SettingsType {
  String get title {
    switch (this) {
      case SettingsType.vibration:
        return LocaleKeys.vibration_on_completion.tr();
      case SettingsType.fill:
        return LocaleKeys.animation_to_fill.tr();
      case SettingsType.contactUs:
        return LocaleKeys.contact_us.tr();
      case SettingsType.deleteAds:
        return LocaleKeys.remove_ads.tr();
      case SettingsType.restore:
        return LocaleKeys.restore_purchases.tr();
    }
  }

  String get icon {
    switch (this) {
      case SettingsType.vibration:
        return AppResources.vibration;
      case SettingsType.fill:
        return AppResources.fill;
      case SettingsType.contactUs:
        return AppResources.contactUs;
      case SettingsType.deleteAds:
        return AppResources.deleteAds;
      case SettingsType.restore:
        return AppResources.restore;
    }
  }

  bool get hasSwitch {
    switch (this) {
      case SettingsType.vibration:
      case SettingsType.fill:
        return true;
      case SettingsType.contactUs:
      case SettingsType.deleteAds:
      case SettingsType.restore:
        return false;
    }
  }

  void doAction(BuildContext context) {
    switch (this) {
      case SettingsType.vibration:
        context.read<SettingsCubit>().switchVibration();
      case SettingsType.fill:
        context.read<SettingsCubit>().switchAnimation();
      case SettingsType.contactUs:
        context.router.push(const ContactUsRoute());
      case SettingsType.deleteAds:
        context.read<SettingsCubit>().deleteAds();
      case SettingsType.restore:
        context.read<SettingsCubit>().restorePurchase();
    }
  }

  static final optionsWithSwitcher = [
    SettingsType.vibration,
    SettingsType.fill,
  ];

  static List<SettingsType> optionsWithNoSwitcher(bool hasAds) => [
        SettingsType.contactUs,
        if (hasAds) SettingsType.deleteAds,
        SettingsType.restore,
      ];
}
