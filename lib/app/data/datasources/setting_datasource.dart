import 'package:karabookapp/app/data/models/progress.dart';
import 'package:karabookapp/app/data/models/user_model.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/services/isar/isar_service.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/network/api_provider.dart';
import 'package:karabookapp/services/network/links.dart';

abstract class ISettingDataSource {
  Future<int?> getUser(String email);
  Future<void> deleteAccount(int userId);
  Future<void> updateProgress(int userId);
}

class SettingDataSource extends ISettingDataSource {
  SettingDataSource() : _apiProvider = ApiProvider.shared;
  final ApiProvider _apiProvider;

  @override
  Future<int?> getUser(String email) async {
    var response = await _apiProvider.get('${Links.userByEmail}?value=$email');
    if (response.data != null && response.data?.isNotEmpty) {
      final data = UserModel.fromJson(response.data);
      updateProgress(data.id);
      return data.id;
    }
    response = await _apiProvider.post(Links.userAdd, {'userEmail': email});
    if (response.data != null) {
      final data = UserModel.fromJson(response.data);
      updateProgress(data.id);
      return data.id;
    }
    return null;
  }

  @override
  Future<void> deleteAccount(int userId) async {
    var response = await _apiProvider.delete(
      '${Links.userDelete}?value=$userId',
    );
    if (response.statusCode == 200) return;

    throw Exception('Error while delete user!!!');
  }

  @override
  Future<void> updateProgress(int userId) async {
    final response =
        await _apiProvider.get('${Links.progressByUser}?value=$userId');

    final data =
        (response.data as List).map((e) => Progress.fromJson(e)).toList();

    final localImages =
        await IsarService.shared.getObjects(from: isar.imageModels);

    /// compare local progress data with server
    for (final serverProgress in data) {
      var localImage =
          localImages.firstWhereOrNull((li) => li.id == serverProgress.imageId);

      late final completedIds = serverProgress.completedParts
          ?.replaceAll(' ', '')
          .split(',')
          .map((e) => int.tryParse(e))
          .toList();
      late final sCompletedIds = completedIds?.whereType<int>().toList() ?? [];

      /// if local progress is blank, it should be saved on phone
      if (localImage == null) {
        localImage = await _downloadImage(serverProgress.imageId);
        if (localImage == null) break;

        _updateIsarImage(
          imageModel: localImage,
          sCompletedIds: sCompletedIds,
          isCompleted: serverProgress.isCompleted,
        );
      } else {
        if (localImage.modifiedDate == serverProgress.modifiedDate) break;

        final lCompletedIds = localImage.completedIds ?? [];
        if (localImage.isCompleted == true &&
                serverProgress.isCompleted == false ||
            sCompletedIds.length < lCompletedIds.length) {
          _updateServerProgress(
            isCompleted: localImage.isCompleted == true,
            lCompletedIds: lCompletedIds,
            sProgress: serverProgress,
            isPut: true,
            imageId: localImage.id,
            userId: userId,
          );
        } //
        else if (serverProgress.isCompleted == true &&
                localImage.isCompleted == false ||
            sCompletedIds.length > lCompletedIds.length) {
          _updateIsarImage(
            imageModel: localImage,
            sCompletedIds: serverProgress.isCompleted ? [] : sCompletedIds,
            isCompleted: serverProgress.isCompleted,
          );
        }
      }
    }

    //  compare server progress data with local
    for (final localImage in localImages) {
      final serverProgress =
          data.firstWhereOrNull((sp) => sp.imageId == localImage.id);
      if (serverProgress == null &&
          (localImage.completedIds?.isNotEmpty ?? false)) {
        _updateServerProgress(
          isCompleted: localImage.isCompleted == true,
          lCompletedIds: localImage.completedIds ?? [],
          sProgress: null,
          isPut: false,
          userId: userId,
          imageId: localImage.id,
        );
      }
    }
  }

  Future<ImageModel?> _downloadImage(int id) async {
    final response = await ApiProvider.shared.get(
      '${Links.imageByIds}?value=$id',
    );

    final parseUpdImages =
        (response.data as List).map((e) => ImageModel.fromJson(e)).toList();

    // update ISAR
    for (final image in parseUpdImages) {
      IsarService.shared.writeSync(
        object: image,
        to: isar.imageModels,
      );
    }

    return parseUpdImages.firstOrNull;
  }

  Future<void> _updateIsarImage({
    required ImageModel imageModel,
    required bool isCompleted,
    required List<int> sCompletedIds,
  }) async {
    final imageProgress = imageModel.copyWith(
      isCompleted: isCompleted,
      completedIds: sCompletedIds,
    );

    await IsarService.shared.writeSync(
      object: imageProgress,
      to: isar.imageModels,
    );
  }

  Future<void> _updateServerProgress({
    required bool isCompleted,
    required Progress? sProgress,
    required List<int> lCompletedIds,
    required bool isPut,
    required int userId,
    required int imageId,
  }) async {
    final progress = sProgress != null
        ? sProgress.copyWith(
            isCompleted: isCompleted,
            completedParts: isCompleted ? null : lCompletedIds.join(','),
            modifiedDate: DateTime.now().toUtc().microsecondsSinceEpoch,
          )
        : Progress(
            imageId: imageId,
            userId: userId,
            isCompleted: isCompleted,
            completedParts: lCompletedIds.join(','),
          );

    if (isPut) {
      await _apiProvider.put(Links.progressUpdate, progress.toJsonPut());
    } else {
      await _apiProvider.post(Links.progressAdd, progress.toJson());
    }
  }
}
