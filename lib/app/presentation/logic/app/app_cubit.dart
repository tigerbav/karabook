import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/services/network/api_provider.dart';

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

  Future<void> setMenu() async {
    emit(AppSplash(isLoading: true));
    try {
      await ApiProvider.shared.getAllSvgImage();
      await ApiProvider.shared.getAllImageCategory();
      await ApiProvider.shared.getAllPacks();
      // await ApiProvider.shared.createAchievementsProgress();
    } catch (e) {
      print(e);
    }

    emit(AppMenu());
  }
}
