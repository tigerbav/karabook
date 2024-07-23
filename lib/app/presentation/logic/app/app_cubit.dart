import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/services/managers/data_manager.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSplash()) {
    _setup();
  }

  Future<void> _setup() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> goToApp() async {
    emit(AppSplash(isLoading: true));

    try {
      await DataManager.shared.getAllLocales();
      await DataManager.shared.getAllTexts();
      await DataManager.shared.getAllCategories();
    } catch (e) {
      debugPrint(e.toString());
    }

    emit(AppMenu(lifecycleState: App.lifecycleState));
  }

  void updateLifecycleState(AppLifecycleState lifecycleState) {
    if (state is AppMenu) emit(state.setLifecycle(lifecycleState));
  }
}
