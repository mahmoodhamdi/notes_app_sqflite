import 'package:notes_app_sqflite/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, dataBaseName);
    Database database = await openDatabase(path,
        onCreate: onCreate, version: 1, onUpgrade: onUpgrade);
    return database;
  }

  onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('''
ALTER TABLE notes ADD COLUMN color TEXT


''');
    print("onUpgrade==========================>");
  }

 onCreate(Database database, int version) async {
  await database.execute('''
    CREATE TABLE "notes" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "color" TEXT NOT NULL,
      "content" TEXT NOT NULL
    )
  ''');
  print("on create database=====================>");
}


  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteMyDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, dataBaseName);
    await deleteDatabase(path);
  }
}
