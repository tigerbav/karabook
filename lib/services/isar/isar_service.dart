import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/isar/models/locale_model.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/isar/models/text_model.dart';
import 'package:karabookapp/services/isar/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

class IsarService {
  IsarService._();
  static IsarService shared = IsarService._();

  Future<void> setup() async {
    if (Isar.instanceNames.isNotEmpty) {
      isar = await Future.value(Isar.getInstance());
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        PainterProgressSchema,
        CategoryModelSchema,
        ImageModelSchema,
        LocaleModelSchema,
        TextModelSchema,
        UserModelSchema,
      ],
      directory: dir.path,
    );
    await _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final images = await isar.imageModels.where().findAll();
      for (final image in images) {
        if (image.imageRawData == null) continue;
        final loader = SvgStringLoader(image.imageRawData!);
        svg.cache.putIfAbsent(
          loader.cacheKey(null),
          () => loader.loadBytes(null),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> writeSync<T>({
    required T object,
    required IsarCollection<T> to,
  }) async {
    try {
      await isar.writeTxn(() async {
        await to.put(object);
      });
      return true;
    } catch (e) {
      debugPrint('ISAR: ${to.name} write error - $e.');
      return false;
    }
  }

  Future<T?> getObject<T>({int id = 0, required IsarCollection<T> from}) async {
    try {
      final object = await from.get(id);
      return object;
    } catch (e) {
      debugPrint('ISAR: ${from.name} get error - $e.');
      return null;
    }
  }

  Future<List<T>> getObjects<T>({required IsarCollection<T> from}) async {
    try {
      final objects = await from.where().findAll();
      return objects;
    } catch (e) {
      debugPrint('ISAR: ${from.name} get error - $e.');
      return [];
    }
  }

  Future<void> deleteObjects<T>({
    required List<int> ids,
    required IsarCollection<T> from,
  }) async {
    try {
      await isar.writeTxn(() async {
        await from.deleteAll(ids);
      });
    } catch (e) {
      debugPrint('ISAR: ${from.name} delete error - $e.');
    }
  }

  /// Returns [bool] that indicates whether operation was successful or not
  bool clearAndWriteAllSync<T>({
    required IsarCollection<T> collection,
    required List<T> list,
  }) {
    try {
      isar.writeTxnSync(() {
        collection.clearSync();
        collection.putAllSync(list);
      });
      return true;
    } catch (e) {
      debugPrint('ISAR: ${collection.name} clearAndWriteAll error - $e.');
      return false;
    }
  }
}
