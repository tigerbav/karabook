import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/domain/repositories/setting_repository.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/auth_service.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState()) {
    _init();
  }
  final ISettingRepository _repository;

  Future<void> _init() async {
    final vibration = await SharedPrefManager.shared.get(C.vibration);
    final fillAnimation = await SharedPrefManager.shared.get(C.fillAnimation);

    final email = await SharedPrefManager.shared.get(C.googleSignIn);
    final isAvailable = await PurchasesManager.shared.check(C.removeAds);

    emit(state.copyWith(
      isVibration: vibration is bool ? vibration : false,
      isAnimation: fillAnimation is bool ? fillAnimation : false,
      email: email is String && email.isNotEmpty ? email : null,
      isAds: isAvailable == false,
    ));
  }

  void switchVibration() {
    SharedPrefManager.shared.write(C.vibration, !state.isVibration);
    emit(state.copyWith(isVibration: !state.isVibration));
  }

  void switchAnimation() {
    SharedPrefManager.shared.write(C.fillAnimation, !state.isAnimation);
    emit(state.copyWith(isAnimation: !state.isAnimation));
  }

  Future<void> _getUser(String email) async {
    await _repository.getUser(email);
  }

  Future<void> getUserEmail() async {
    final email = await AuthService().loginWithGoogle();
    SharedPrefManager.shared.write(C.googleSignIn, email ?? '');
    if (email != null) await _getUser(email);
    emit(SettingsState(
      isAnimation: state.isAnimation,
      isVibration: state.isVibration,
      isAds: state.isAds,
      email: email == null || email.isEmpty ? null : email,
    ));
  }

  Future<void> deleteAds() async {
    final offering = await PurchasesManager.shared.fetch(C.removeAds);
    if (offering == null || offering.lifetime == null) {
      Utils.showToast(
        App.navigatorKey.currentContext!,
        LocaleKeys.something_went_wrong.tr(),
      );
      return;
    }

    final result = await PurchasesManager.shared.buy(offering.lifetime!);

    emit(state.copyWith(isAds: result == false));
  }

  Future<void> restorePurchase() async {
    final customerInfo = await PurchasesManager.shared.restorePurchase();
    if (customerInfo == null) {
      Utils.showToast(
        App.navigatorKey.currentContext!,
        LocaleKeys.something_went_wrong.tr(),
      );
      return;
    }

    final result = customerInfo.entitlements.all[C.removeAds]?.isActive == true;

    emit(state.copyWith(isAds: result == false));
  }
}
