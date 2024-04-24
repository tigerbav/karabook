import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _init();
  }

  Future<void> _init() async {
    final vibration = await SharedPrefManager.share.get(C.vibration);
    final fillAnimation = await SharedPrefManager.share.get(C.fillAnimation);

    emit(state.copyWith(
      isVibration: vibration is bool ? vibration : false,
      isAnimation: fillAnimation is bool ? fillAnimation : false,
    ));
  }

  void switchVibration() {
    SharedPrefManager.share.write(C.vibration, !state.isVibration);
    emit(state.copyWith(isVibration: !state.isVibration));
  }

  void switchAnimation() {
    SharedPrefManager.share.write(C.fillAnimation, !state.isAnimation);
    emit(state.copyWith(isAnimation: !state.isAnimation));
  }
}
