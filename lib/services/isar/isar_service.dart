import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:karabookapp/services/isar/models/image_category.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';
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
        ImageCategorySchema,
        SvgImageSchema,
      ],
      directory: dir.path,
    );
  }

  Future<bool> writeSync<T>({
    required T object,
    required IsarCollection<T> to,
  }) async {
    try {
      await isar.writeTxn(() async {
        await to.put(object);
      });
      debugPrint('ISAR: ${to.name} write success.');
      return true;
    } catch (e) {
      debugPrint('ISAR: ${to.name} write error - $e.');
      return false;
    }
  }

  Future<T?> getObject<T>({int id = 0, required IsarCollection<T> from}) async {
    try {
      final object = await from.get(id);
      if (object == null) {
        debugPrint('ISAR: ${from.name} there is no requested object.');
      } else {
        debugPrint('ISAR: ${from.name} get success.');
      }
      return object;
    } catch (e) {
      debugPrint('ISAR: ${from.name} get error - $e.');
      return null;
    }
  }

  Future<List<T>> getObjects<T>({required IsarCollection<T> from}) async {
    try {
      final objects = await from.where().findAll();
      if (objects.isEmpty) {
        debugPrint('ISAR: ${from.name} there is no requested objects.');
      } else {
        debugPrint('ISAR: ${from.name} get success.');
      }
      return objects;
    } catch (e) {
      debugPrint('ISAR: ${from.name} get error - $e.');
      return [];
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
      debugPrint('ISAR: ${collection.name} clearAndWriteAll success.');
      return true;
    } catch (e) {
      debugPrint('ISAR: ${collection.name} clearAndWriteAll error - $e.');
      return false;
    }
  }
}
