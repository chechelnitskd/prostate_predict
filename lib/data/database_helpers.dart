import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'user_data.dart';
import 'data_constants.dart';

// SOURCE: https://pusher.com/tutorials/local-data-flutter/#saving-to-a-database
// https://pub.dev/packages/sqflite

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  //https://stackoverflow.com/questions/67049107/the-non-nullable-variable-database-must-be-initialized
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  // open the database
  Future<Database> _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableName (
                $columnId INTEGER PRIMARY KEY,
                $columnRiskType TEXT NOT NULL,
                $columnRiskScore INTEGER NOT NULL
                
              )
              ''');
    //$columnDate INTEGER NOT NULL
  }

  // Database helper methods:

  Future<int> insert(UserHistory entry) async {
    Database db = await database;
    int id = await db.insert(tableName, entry.toMap());
    return id;
  }

  Future<UserHistory> queryEntry(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: [columnId, columnRiskType, columnRiskScore, ], //columnDate
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return UserHistory.fromMap(maps.first);
    }
    return UserHistory(); // instead of null
  }

  // https://petercoding.com/flutter/2021/03/21/using-sqlite-in-flutter/#create-a-table-in-sqlite
// TODO: queryAllWords()
  Future<List<UserHistory>> queryAllHistory() async {
    Database db = await database;
    final List<Map<String, Object?>> queryResult = await db.query(tableName);
    return queryResult.map((e) => UserHistory.fromMap(e)).toList();
    // or db.query(tableWords);
  }

// TODO: delete(int id)
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(
      '$columnRiskType',
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  // https://stackoverflow.com/questions/54102043/how-to-do-a-database-update-with-sqflite-in-flutter
// TODO: update(Word word)
  Future<int> update(UserHistory entry) async {
    Database db = await database;
    return await db.update(tableName, entry.toMap(),
        where: '$columnId = ?', whereArgs: [entry.id]);
  }

  // TODO: does this work?
  Future close() async {
    Database db = await database;
    db.close();
  }
}

