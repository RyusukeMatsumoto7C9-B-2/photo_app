import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_app/Photo.dart';


class PhotoDataSqfliteRepository 
{
  static const String ID = 'id';
  static const String RAW_DATA = 'photo_raw_data';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos.db';

  static Database _db;

  Future<Database> get db async 
  {
    if (null != _db) 
    {
      return _db;
    }
    _db = await initDB();
    return _db;
  }


  initDB() async 
  {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }


  _onCreate(Database db, int version) async 
  {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $RAW_DATA TEXT)");
  }


  deleteDataInDB() async 
  {
    var dbClient = await db;
    dbClient.execute("DELETE FROM $TABLE");
  }


  Future<Photo> save(Photo employee) async 
  {
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE, employee.toMap());
    return employee;
  }


  Future<List<Photo>> getPhotos() async
  {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, RAW_DATA]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int _id = 0; _id < maps.length; _id++) {
        employees.add(Photo.fromMap(maps[_id]));
      }
    }
    return employees;
  }


  Future close() async 
  {
    var dbClient = await db;
    dbClient.close();
  }

}