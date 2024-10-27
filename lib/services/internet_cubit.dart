import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';

class InternetCubit extends Cubit<InternetConnectionStatus?> {
  static final checker = InternetConnectionChecker();

  InternetCubit() : super(null) {
    /// Need to skip first status, as sometimes it is not right one
    checker.onStatusChange.skip(1).listen((status) async {
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(status);
        case InternetConnectionStatus.disconnected:
          // When app in background - internet checker works incorrectly
          if (App.lifecycleState != AppLifecycleState.resumed) return;

          /// Make some delay for cases,
          /// when app looses connection just for a little moment
          await Future.delayed(Duration(seconds: Platform.isAndroid ? 3 : 1));

          /// Check whether it is still no internet connection
          if (status == InternetConnectionStatus.disconnected) emit(status);
      }
    });
  }
  bool get isDisconnected => state == InternetConnectionStatus.disconnected;

  /// Recheck internet connection state, when app returns from background
  Future<void> didChangeAppLifecycle(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) return;

    final status = await checker.connectionStatus;
    if (status == InternetConnectionStatus.disconnected) emit(status);
  }
}
