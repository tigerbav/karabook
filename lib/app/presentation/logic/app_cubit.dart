import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    //TODO: call all API methods
  }

  void setMenu() {
    emit(AppMenu());
  }
}
