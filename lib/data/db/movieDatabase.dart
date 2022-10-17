import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:visuamos/data/models/dreamMovieData.dart';

class DreamMovieDB {
  final String dbName;
  Database? _db;
  List<DreamMovieData> _dreamMoviesList = [];
  final _streamController = StreamController<List<DreamMovieData>>.broadcast();

  DreamMovieDB({required this.dbName});

  Future<List<DreamMovieData>> _fetchDreamMovies() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query('dreamMovie', orderBy: 'id DESC');
      List<DreamMovieData> imagesList = read.isNotEmpty
          ? read.map((c) => DreamMovieData.fromMap(c)).toList()
          : [];
      print('4');
      return imagesList;
    } catch (e) {
      print('Error fetching Movie Data from DB = $e');
      return [];
    }
  }

  Future<bool> addDreamMovieData(
    String image1,
    String image2,
    String image3,
    String caption1,
    String caption2,
    String caption3,
    String audio,
  ) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = await db.insert('dreamMovie', {
        'image1': image1,
        'image2': image2,
        'image3': image3,
        'caption1': caption1,
        'caption2': caption2,
        'caption3': caption3,
        'audio': audio,
      });

      _dreamMoviesList = await _fetchDreamMovies();
      _streamController.add(_dreamMoviesList);
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

  Future<bool> open() async {
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

      const create = '''CREATE TABLE IF NOT EXISTS dreamMovie(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          image1 STRING NOT NULL,
          image2 STRING NOT NULL,
          image3 STRING NOT NULL,
          caption1 STRING NOT NULL,
          caption2 STRING NOT NULL,
          caption3 STRING NOT NULL,
          audio STRING NOT NULL
      )''';
      await db.execute(create);

      // read all data
      final dreamMoviesList = await _fetchDreamMovies();
      _dreamMoviesList = dreamMoviesList;
      _streamController.add(_dreamMoviesList);
      return true;
    } catch (e) {
      print('Error = $e');
      return false;
    }
  }

  get all => _streamController.stream;
}
