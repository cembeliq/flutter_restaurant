import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

import '../model/restaurant.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
    return _databaseHelper;
  }

  static const String _tblBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/restaurantapp.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblBookmark (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             city TEXT,
             address TEXT,
             rating REAL,
             pictureId TEXT
           )     ''');
    }, version: 1);

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;
    var sql =
        'INSERT INTO $_tblBookmark(id, name, description, city, address, rating, pictureId) values(?,?,?,?,?,?,?)';
    print(restaurant.id +
        restaurant.name +
        restaurant.description +
        restaurant.city +
        restaurant.address +
        restaurant.rating.toString() +
        restaurant.pictureId);
    await db.rawInsert(sql, [
      restaurant.id,
      restaurant.name,
      restaurant.description,
      restaurant.city,
      restaurant.address,
      restaurant.rating,
      restaurant.pictureId
    ]);
    // await db.insert(_tblBookmark, restaurant.toJson());
  }

  Future<List<Restaurant>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblBookmark);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;
    await db.delete(_tblBookmark, where: 'id = ?', whereArgs: [id]);
  }
}
