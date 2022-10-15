import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visuamos/data/models/simpleImageData.dart';

class VisuamosDB {
  final String dbName;
  Database? _db;
  List<SimpleImageData> _simpleImagesList = [];
  final _streamController = StreamController<List<SimpleImageData>>.broadcast();

  VisuamosDB({required this.dbName});

  Future<List<SimpleImageData>> _fetchSimpleImages(int imageType) async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query('simpleImage',
          where: 'imageType = ?', whereArgs: [imageType], orderBy: 'id DESC');
      List<SimpleImageData> imagesList = read.isNotEmpty
          ? read.map((c) => SimpleImageData.fromMap(c)).toList()
          : [];
      return imagesList;
    } catch (e) {
      print('Error fetching Image Data from DB = $e');
      return [];
    }
  }

  Future<bool> addImageData(String name, String amount, String date,
      String coupon, int imageType) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = await db.insert('simpleImage', {
        'name': name,
        'amount': amount,
        'date': date,
        'coupon': coupon,
        'imageType': imageType
      });

      _simpleImagesList = await _fetchSimpleImages(imageType);
      _streamController.add(_simpleImagesList);
      return true;
    } catch (e) {
      print('Error in adding Image Data = $e');
      return false;
    }
  }

  Future<bool> close() async {
    final db = _db;
    if (db == null) {
      return false;
    }
    await db.close();
    return true;
  }

  Future<bool> open(int imageType) async {
    if (_db != null) {
      return true;
    }
    Directory? directory = Platform.isAndroid
        ? await getApplicationDocumentsDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();

    final path = '${directory.path}/$dbName';
    try {
      final db = await openDatabase(path);
      _db = db;

      const create = '''CREATE TABLE IF NOT EXISTS simpleImage(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING NOT NULL,
          amount STRING NOT NULL,
          date STRING NOT NULL,
          coupon STRING,
          imageType INTEGER NOT NULL
      )''';
      await db.execute(create);

      // read all data
      final simpleImagesList = await _fetchSimpleImages(imageType);
      _simpleImagesList = simpleImagesList;
      _streamController.add(_simpleImagesList);
      return true;
    } catch (e) {
      print('Error = $e');
      return false;
    }
  }

  get all => _streamController.stream;
}
