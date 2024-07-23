import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/domain/repositories/setting_repository.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/auth_service.dart';
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

    String? email;
    final isSigned = await AuthService.googleSignIn.isSignedIn();
    if (isSigned) email = await getUserEmail(isEmit: false);

    emit(state.copyWith(
      isVibration: vibration is bool ? vibration : false,
      isAnimation: fillAnimation is bool ? fillAnimation : false,
      email: email,
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

  Future<String?> getUserEmail({bool isEmit = true}) async {
    final email = await AuthService().loginWithGoogle();
    if (isEmit == true) {
      emit(SettingsState(
        isAnimation: state.isAnimation,
        isVibration: state.isVibration,
        isAds: state.isAds,
        email: email,
      ));
    }
    if (email != null) await _getUser(email);

    return email;
  }
}
