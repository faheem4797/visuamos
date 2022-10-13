import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visuamos/data/models/simpleImageData.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  List<SimpleImageData> _simpleImageList = [];
  final _streamController = StreamController<List<SimpleImageData>>.broadcast();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    print('in this');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory.path);
    String path = join(documentsDirectory.path, 'visuamos.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    print('anything');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS simpleImage(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          amount TEXT,
          date TEXT,
          coupon TEXT,
          imageType INTEGER
      )
      ''');
    print('??');
    //_simpleImageList = await getSimpleImages(0);
    print(_simpleImageList[0]);
    //_streamController.add(_simpleImageList);
  }

  Future<List<SimpleImageData>> getSimpleImages(int imageType) async {
    Database db = await instance.database;
    var images = await db.query('simpleImage',
        where: 'imageType = ?', whereArgs: [imageType], orderBy: 'id DESC');
    List<SimpleImageData> imagesList = images.isNotEmpty
        ? images.map((c) => SimpleImageData.fromMap(c)).toList()
        : [];
    _simpleImageList = imagesList;
    _streamController.add(_simpleImageList);
    return imagesList;
  }

  Future<bool> add(SimpleImageData simpleImage) async {
    print('in here');
    Database db = await instance.database;

    print('in here 1');
    var a = await db.insert('simpleImage', simpleImage.toMap());
    if (a == 0) {
      return false;
    } else {
      _simpleImageList.insert(0, simpleImage);
      _streamController.add(_simpleImageList);
      return true;
    }
  }

  deleteAll() async {
    final db = await instance.database;
    db.rawDelete("Delete from simpleImage");
  }

  get simpleImages => _streamController.stream;
}
