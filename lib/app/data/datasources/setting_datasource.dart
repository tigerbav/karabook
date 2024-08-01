import 'package:flutter/foundation.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/common/widgets/restart_widget.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/isar/models/user_model.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class ISettingDataSource {
  static int userId = 0;
  Future<void> getUser(String email);
}

class SettingDataSource extends ISettingDataSource {
  SettingDataSource() : _apiProvider = ApiProvider.shared;
  final ApiProvider _apiProvider;

  @override
  Future<void> getUser(String email) async {
    var response = await _apiProvider.get('${Links.userByEmail}?value=$email');
    if (response.data != null && response.data?.isNotEmpty) {
      final data = UserModel.fromJson(response.data);
      _updateProgress(data.id);
      return;
    }
    response = await _apiProvider.post(Links.userAdd, {'userEmail': email});
    if (response.data != null) {
      final data = UserModel.fromJson(response.data);
      _updateProgress(data.id);
    }
  }

  Future<void> _updateProgress(int userId) async {
    ISettingDataSource.userId = userId;
    final response =
        await _apiProvider.get('${Links.progressByUser}?value=$userId');

    final data =
        (response.data as List).map((e) => Progress.fromJson(e)).toList();

    final localData =
        await IsarService.shared.getObjects(from: isar.painterProgress);

    bool shouldRestart = false;
    // compare local progress data with server
    for (final serverProgress in data) {
      final localProgress =
          localData.firstWhereOrNull((lp) => lp.id == serverProgress.imageId);
      if (localProgress == null) {
        final completedIds = serverProgress.completedParts
            ?.replaceAll(' ', '')
            .split(',')
            .map((e) => int.tryParse(e))
            .toList();

        final painterProgress = PainterProgress()
          ..id = serverProgress.imageId
          ..isCompleted = serverProgress.isCompleted
          ..completedIds = completedIds?.whereType<int>().toList();

        IsarService.shared.writeSync(
          object: painterProgress,
          to: isar.painterProgress,
        );
        shouldRestart = true;
      }
    }

    //  compare server progress data with local
    for (final localProgress in localData) {
      final serverProgress =
          data.firstWhereOrNull((lp) => lp.imageId == localProgress.id);
      if (serverProgress == null) {
        final completedParts = localProgress.isCompleted
            ? null
            : localProgress.completedIds?.map((e) => e.toString()).join(',');

        final painterProgress = Progress(
          id: 0,
          imageId: localProgress.id,
          userId: userId,
          isCompleted: localProgress.isCompleted,
          completedParts: completedParts,
        );

        try {
          await _apiProvider.post(Links.progressAdd, painterProgress.toJson());
        } catch (_) {
          debugPrint('Can\'t update progress on server');
        }
      }
    }
    if (shouldRestart) {
      RestartWidget.restartApp(App.navigatorKey.currentContext!);
    }
  }
}
