import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/app/data/models/user_model.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class IGameDataSource {
  Future<void> updateImage(ImageModel image);
  Future<List<int>> getProgress(int id);
  Future<void> updateServer(Progress progress);
  Future<int> getHints();
  Future<void> setHints(int number);
}

class GameDataSource extends IGameDataSource {
  final ApiProvider _apiProvider;
  GameDataSource() : _apiProvider = ApiProvider.shared;
  @override
  Future<void> updateImage(ImageModel image) async {
    await IsarService.shared.writeSync<ImageModel>(
      object: image,
      to: isar.imageModels,
    );
  }

  @override
  Future<List<int>> getProgress(int id) async {
    final result = await IsarService.shared.getObject(
      from: isar.imageModels,
      id: id,
    );
    if (result == null || result.completedIds == null) return [];

    return result.completedIds!;
  }

  @override
  Future<void> updateServer(Progress progress) async {
    try {
      await _apiProvider.delete(
        '${Links.deleteByUserAndImage}?userId=${progress.userId}&imageId=${progress.imageId}',
      );
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Can\'t update progress on server');
    }
    try {
      await _apiProvider.post(Links.progressAdd, progress.toJson());
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Can\'t update progress on server');
    }
  }

  @override
  Future<int> getHints() async {
    final context = App.navigatorKey.currentContext;
    if (context == null) return 0;

    final email = context.read<SettingsCubit>().state.email;
    if (email == null || email.isEmpty) return 0;

    final response =
        await _apiProvider.get('${Links.userByEmail}?value=$email');
    if (response.data == null || response.data?.isEmpty) return 0;

    final data = UserModel.fromJson(response.data);
    return data.hintsAmount;
  }

  @override
  Future<void> setHints(int number) async {
    final userId = await SharedPrefManager.shared.get(C.lastUserId);
    if (userId is! int || userId == 0) return;

    await _apiProvider.patch(
      Links.userPatch,
      UserModel(id: userId, hintsAmount: number).toMap(),
    );
  }
}
