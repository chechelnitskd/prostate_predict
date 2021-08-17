import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'user_data.dart';
import 'data_constants.dart';

// SOURCE: https://pusher.com/tutorials/local-data-flutter/#saving-to-a-database
// https://pub.dev/packages/sqflite


// data model class
class Word {

  //not sure if making them ? is the best way
  int? id;
  String? word;
  int? frequency;

  Word();
  //this.id, this.word, this.frequency

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.word = map[columnWord];
    this.frequency = map[columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWord: word,
      columnFrequency: frequency
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

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
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY,
                $columnWord TEXT NOT NULL,
                $columnFrequency INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableWords, word.toMap());
    return id;
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableWords,
        columns: [columnId, columnWord, columnFrequency],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return Word(); // instead of null
  }

  // https://petercoding.com/flutter/2021/03/21/using-sqlite-in-flutter/#create-a-table-in-sqlite
// TODO: queryAllWords()
  Future<List<Word>> queryAllWords() async {
    Database db = await database;
    final List<Map<String, Object?>> queryResult = await db.query(tableWords);
    return queryResult.map((e) => Word.fromMap(e)).toList();
    // or db.query(tableWords);
  }

// TODO: delete(int id)
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(
      '$columnWord',
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  // https://stackoverflow.com/questions/54102043/how-to-do-a-database-update-with-sqflite-in-flutter
// TODO: update(Word word)
  Future<int> update(Word word) async {
    Database db = await database;
    return await db.update(tableWords, word.toMap(),
        where: '$columnId = ?', whereArgs: [word.id]);
  }

  // TODO: does this work?
  Future close() async {
    Database db = await database;
    db.close();
  }
}

_read() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  int rowId = 1;
  Word word = await helper.queryWord(rowId);
  if (word.id == null) {
    print('read row $rowId: empty');
  } else {
    print('read row $rowId: ${word.word} ${word.frequency}');
  }
}

_save() async {
  Word word = Word();
  word.word = 'hello';
  word.frequency = 15;
  DatabaseHelper helper = DatabaseHelper.instance;
  int id = await helper.insert(word);
  word.id = id;
  print('inserted row: $id');
}

_printAll() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  List<Word> words = await helper.queryAllWords();
  for (var i = 0; i < words.length; i++) {
    print("ID: ${words[i].id}, Word: ${words[i].word}\n");
  }
  print("done");
}