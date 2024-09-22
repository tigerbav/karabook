import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:karabookapp/app/domain/repositories/setting_repository.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/auth_service.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState()) {
    _init();
  }
  final ISettingRepository _repository;

  Future<void> _init() async {
    final vibration = await SharedPrefManager.shared.get(C.vibration);
    final fillAnimation = await SharedPrefManager.shared.get(C.fillAnimation);
    final autoFill = await SharedPrefManager.shared.get(C.fillHint);

    String? email;

    final isGoogle = await SharedPrefManager.shared.get(C.googleLastSignIn);
    final isApple = await SharedPrefManager.shared.get(C.appleLastSignIn);
    if (isGoogle != null && isGoogle is bool && isGoogle == true) {
      email =
          await SharedPrefManager.shared.get(C.googleSignInEmail) as String?;
    } else if (isApple != null && isApple is bool && isApple == true) {
      email = await const FlutterSecureStorage().read(key: C.appleSignInEmail);
    }

    final isAdsAvailable = await PurchasesManager.shared.check(C.removeAds);
    var userId = await SharedPrefManager.shared.get(C.lastUserId);
    userId = userId is int? ? userId : null;

    if (email != null && email.isNotEmpty && userId != null) {
      _repository.updateProgress(userId);
    }

    emit(SettingsState(
      isVibration: vibration is bool ? vibration : false,
      isAnimation: fillAnimation is bool ? fillAnimation : false,
      isFillHint: autoFill is bool ? autoFill : false,
      email: email != null && email.isNotEmpty ? email : null,
      isAds: isAdsAvailable == false,
      userId: userId,
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

  void switchFillHint() {
    SharedPrefManager.shared.write(C.fillHint, !state.isFillHint);
    emit(state.copyWith(isFillHint: !state.isFillHint));
  }

  Future<void> googleSignIn() async {
    final email = await AuthService().loginWithGoogle();
    SharedPrefManager.shared.write(C.googleSignInEmail, email ?? '');
    SharedPrefManager.shared.write(C.googleLastSignIn, true);

    int? userId;

    if (email != null) {
      final result = await _repository.getUser(email);
      if (result.isRight) userId = result.right;
    }

    emit(SettingsState(
      isAnimation: state.isAnimation,
      isVibration: state.isVibration,
      isAds: state.isAds,
      email: email == null || email.isEmpty ? null : email,
      userId: userId,
    ));
  }

  Future<void> logout() async {
    final isGoogle = await SharedPrefManager.shared.get(C.googleLastSignIn);
    final isApple = await SharedPrefManager.shared.get(C.appleLastSignIn);
    if (isGoogle != null && isGoogle is bool && isGoogle == true) {
      await AuthService().logoutWithGoogle();
      await SharedPrefManager.shared.write(C.googleLastSignIn, false);
    } else if (isApple != null && isApple is bool && isApple == true) {
      await SharedPrefManager.shared.write(C.appleLastSignIn, false);
    }

    await SharedPrefManager.shared.write(C.lastUserId, 0);

    emit(SettingsState(
      isAnimation: state.isAnimation,
      isVibration: state.isVibration,
      isFillHint: state.isFillHint,
      isAds: state.isAds,
      email: null,
      userId: null,
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

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          // AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (credential.email == null && credential.identityToken == null) {
        Utils.showToast(
          context,
          LocaleKeys.something_went_wrong.tr(),
        );
        return;
      }

      /// user can give email just at first time
      final email = await const FlutterSecureStorage().read(
        key: C.appleSignInEmail,
      );

      if (email == null && credential.email != null) {
        await const FlutterSecureStorage().write(
          key: C.appleSignInEmail,
          value: credential.email!,
        );
      } else if (email == null && credential.email == null) {
        Utils.showToast(
          context,
          LocaleKeys.something_went_wrong.tr(),
        );
        return;
      }
      await SharedPrefManager.shared.write(C.appleLastSignIn, true);

      int? userId;
      if (email != null) {
        final result = await _repository.getUser(credential.email ?? email);
        if (result.isRight) userId = result.right;
      }

      emit(state.copyWith(
        email: credential.email ?? email,
        userId: userId,
      ));
    } catch (e) {
      debugPrint(e.toString());
      Utils.showToast(
        context,
        LocaleKeys.something_went_wrong.tr(),
      );
    }
  }

  Future<void> deleteAccount() async {
    if (state.userId == null) return;

    final result = await _repository.deleteAccount(state.userId!);
    if (result.isLeft) return;

    logout();

    emit(SettingsState(
      isAds: state.isAds,
      isVibration: state.isVibration,
      isAnimation: state.isAnimation,
      email: null,
    ));

    await SharedPrefManager.shared.write(C.googleSignInEmail, '');
  }
}
