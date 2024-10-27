import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalManager {
  OneSignalManager._();
  static OneSignalManager shared = OneSignalManager._();

  init() {
    OneSignal.initialize("0d051eb6-015a-4046-98a2-a9d70c8ba6fa");

    OneSignal.Notifications.requestPermission(true);
  }
}
