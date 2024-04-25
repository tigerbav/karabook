import 'dart:core';
import 'dart:io';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/library/data/models/image_category.dart';
import 'package:karabookapp/pages/portfolio/data/models/achievement.dart';
import 'package:karabookapp/services/core/models/db_models/painter_progress_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'kara_book.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ImageCategory('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'createdAt TEXT,'
          'updatedAt TEXT'
          ')');
      await db.execute('CREATE TABLE AchievementsProgress('
          'id INTEGER PRIMARY KEY,'
          'icon TEXT,'
          'title TEXT,'
          'counter INTEGER,'
          'subTitle TEXT,'
          'category TEXT,'
          'progress REAL,'
          'current INTEGER'
          ')');
      await db.execute('CREATE TABLE SvgImage('
          'id INTEGER PRIMARY KEY,'
          'imageParts TEXT,'
          'imageCategory TEXT,'
          'height INTEGER,'
          'width INTEGER,'
          'subCategories TEXT,'
          'complete INTEGER,'
          'achievementsComplete INTEGER DEFAULT 0,'
          'shapes TEXT,'
          'screenProgress BLOB,'
          'isActive INTEGER DEFAULT 0,'
          'createdAt TEXT,'
          'updatedAt TEXT'
          ')');
      await db.execute('CREATE TABLE Packs('
          'id INTEGER PRIMARY KEY,'
          'packName TEXT,'
          'packIcon TEXT,'
          'packDescription TEXT,'
          'packIdentifier TEXT'
          ')');
    });
  }

  // insert data
  createImageCategory(ImageCategory newImageCategory) async {
    var res;
    final db = await database;
    var count = Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) from ImageCategory WHERE id = ?',
        [newImageCategory.id]));

    if (count == 0) {
      res = await db.insert('ImageCategory', newImageCategory.toJson());
      //print('count:  $count');
    } else {
      await db.update('ImageCategory', newImageCategory.toJson(),
          where: 'id = ?', whereArgs: [newImageCategory.id]);
      //print('countUpdate:  $count');
    }

    return res;
  }

  createAchievementsProgress(Achievement achievements) async {
    final db = await database;
    int? count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM AchievementsProgress'));

    if (count == 0) {
      final res = await db.insert('AchievementsProgress', achievements.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    }
  }

  createSvgImage(SvgImage newSvgImage) async {
    var res;
    final db = await database;
    var count = Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) from SvgImage WHERE id = ?', [newSvgImage.id]));

    if (count == 0) {
      res = await db.insert('SvgImage', newSvgImage.toJson());
      //print('count:  $count');
    } else {
      await db.update('SvgImage', newSvgImage.toJson(),
          where: 'id = ?', whereArgs: [newSvgImage.id]);
      //print('countUpdate:  $count');
    }

    return res;
  }

  createPacks(Pack newPacks) async {
    var res;
    final db = await database;
    var count = Sqflite.firstIntValue(await db!
        .rawQuery('SELECT COUNT(*) from Packs WHERE id = ?', [newPacks.id]));

    if (count == 0) {
      res = await db.insert('Packs', newPacks.toJson());
      //print('count:  $count');
    } else {
      await db.update('Packs', newPacks.toJson(),
          where: 'id = ?', whereArgs: [newPacks.id]);
      //print('countUpdate:  $count');
    }

    return res;
  }

  Future<List<Achievement>> getAchievementsList() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM AchievementsProgress");

    List<Achievement> list =
        res.isNotEmpty ? res.map((c) => Achievement.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<ImageCategory>> getImageCategory() async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM ImageCategory WHERE name != 'Comics' AND name != 'Daily'");

    List<ImageCategory> list = res.isNotEmpty
        ? res.map((c) => ImageCategory.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<List<SvgImage>> getCategoryName(String nameCategory) async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM SvgImage WHERE imageCategory = '$nameCategory'");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SvgImage>> getAllImages() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM SvgImage");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SvgImage>> getCategoryNameAndSub(String nameCategory) async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM SvgImage WHERE imageCategory = '$nameCategory' AND subcategories != ''");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SvgImage>> getSubcategory(String nameSubcategory) async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM SvgImage WHERE subcategories = '$nameSubcategory'");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SvgImage>> getSvgImageInProgress(int complete) async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM SvgImage WHERE complete = $complete AND screenProgress != 'Null' AND imageCategory != 'Comics' AND imageCategory != 'Daily' AND imageCategory != 'Vip'");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Pack>> getPacks() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM Packs");

    List<Pack> list =
        res.isNotEmpty ? res.map((c) => Pack.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<SvgImage>> getPacksColoringVIP(String packName) async {
    final db = await database;
    final res = await db!.rawQuery(
        "SELECT * FROM SvgImage WHERE imageCategory = 'Vip' AND subcategories = '$packName'");

    List<SvgImage> list =
        res.isNotEmpty ? res.map((c) => SvgImage.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> updateImageParts(int id, String imageParts) async {
    final db = await database;
    return await db!.rawUpdate(
        'UPDATE SvgImage SET imageParts = $imageParts  WHERE id = $id');
  }

  Future<int> updateComplete(int id, int complete) async {
    final db = await database;
    return await db!
        .rawUpdate('UPDATE SvgImage SET complete = $complete  WHERE id = $id');
  }

  //////////// Методи для опрацювання прогресу гри

  Future<int> addNewPainter(PainterProgressModel painter) async {
    final db = await database;
    return db!.insert(PainterProgressModel.table, painter.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> updatePainter(PainterProgressModel painter) async {
    final db = await database;
    return db!.update(PainterProgressModel.table, painter.toMap(),
        where: 'id = ?',
        whereArgs: [painter.id],
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> deletePainter(String id) async {
    final db = await database;
    return db!
        .delete(PainterProgressModel.table, where: 'id = ?', whereArgs: [id]);
  }

  Future<PainterProgressModel?> getPainter(int id) async {
    final db = await database;
    final res = await db!
        .query(PainterProgressModel.table, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? PainterProgressModel.fromMap(res.first) : null;
  }
}
