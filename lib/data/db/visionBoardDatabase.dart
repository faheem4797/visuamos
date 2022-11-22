import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/data/models/visionBoardData.dart';

class VisionBoardDB {
  final String dbName;
  Database? _db;
  List<VisionBoardData> _visionBoardList = [];
  final _streamController = StreamController<List<VisionBoardData>>.broadcast();

  VisionBoardDB({required this.dbName});

  Future<List<VisionBoardData>> _fetchVisionBoardImages(String uid) async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query('visionBoard',
          where: 'uid = ?', whereArgs: [uid], orderBy: 'id DESC');
      List<VisionBoardData> imagesList = read.isNotEmpty
          ? read.map((c) => VisionBoardData.fromMap(c)).toList()
          : [];
      return imagesList;
    } catch (e) {
      print('Error fetching Image Data from DB = $e');
      return [];
    }
  }

  Future<bool> addVisionBoardImageData(
      String uid,
      String image1,
      String image2,
      String image3,
      String image4,
      String image5,
      String image6,
      String image7,
      String image8,
      String fileName,
      int isPaid,
      String coupon) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = await db.insert('visionBoard', {
        'uid': uid,
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'image4': image4,
        'image5': image5,
        'image6': image6,
        'image7': image7,
        'image8': image8,
        'fileName': fileName,
        'isPaid': isPaid,
        'coupon': coupon
      });

      _visionBoardList = await _fetchVisionBoardImages(uid);
      _streamController.add(_visionBoardList);
      return true;
    } catch (e) {
      print('Error in adding Vision Board Data = $e');
      return false;
    }
  }

  Future<bool> update(int id, String uid, int isPaid) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final updateCount = await db.update(
          'visionBoard',
          {
            'isPaid': isPaid,
          },
          where: 'id = ?',
          whereArgs: [id]);

      _visionBoardList = await _fetchVisionBoardImages(uid);
      _streamController.add(_visionBoardList);
      return true;
    } catch (e) {
      print('Error in updating Movie Data = $e');
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

  Future<bool> open(String uid) async {
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

      const create = '''CREATE TABLE IF NOT EXISTS visionBoard(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          uid STRING NOT NULL,
          image1 STRING NOT NULL,
          image2 STRING NOT NULL,
          image3 STRING NOT NULL,
          image4 STRING NOT NULL,
          image5 STRING NOT NULL,
          image6 STRING NOT NULL,
          image7 STRING NOT NULL,
          image8 STRING NOT NULL,
          fileName STRING NOT NULL,
          isPaid INTEGER NOT NULL,
          coupon STRING
      )''';
      await db.execute(create);

      // read all data
      final visionBoardImagesList = await _fetchVisionBoardImages(uid);
      _visionBoardList = visionBoardImagesList;
      _streamController.add(_visionBoardList);
      return true;
    } catch (e) {
      print('Error = $e');
      return false;
    }
  }

  get all => _streamController.stream;
}
