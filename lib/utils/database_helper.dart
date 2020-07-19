import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:notekeeperapp/models/note.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  Database _database;

  // GOTTA CHECK THIS AFTERWARDS
  String noteTable;
  int colId;
  String colTitle;
  String colDesc;
  String colDate;
  int colPriority;


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper==null){
      _databaseHelper=DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future <Database> get database async {
    if(_database==null){
      await initializeDb();
    }
    return _database;
  }


  Future <Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var db = await openDatabase(path,version: 1,onCreate: _createDb);
    return db;
  }

  void _createDb(Database db,int version) async {
    await db.execute('CREATE TABLE $noteTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT,$colDate TEXT,$colPriority INTEGER)', );
  }

  //fetch

  Future <List<Map<String,dynamic>>>getNotesMapList() async {
    Database db = await database;
    var result = await db.query(noteTable,orderBy: '$colPriority DESC');
    return result;
  }
  //insert
  Future insertNote(Note note) async {
    Database db = await database;
    var result = db.insert(noteTable, note.toMap());
    return result;
  }
  //delete
  //delete function might be weird//
  Future<int> deleteNote(Note note) async {
    Database db = await database;
    var result = await db.delete(noteTable,where: '$colId=note.id');
    return result;
  }
  //update
  Future<int> updateNote(Note note) async {
    Database db = await database;
    var result = await db.update(noteTable, note.toMap(),where: '$colId=?',whereArgs: [note.id]);
    return result;
  }
  //count

  // self made count function(might br wrong)
  Future countNote() async {
    //change to int from List<Map<S,d>>//
    Database db = await database;
    var result = await db.rawQuery('SELECT COUNT($colId) FROM $noteTable');
    return result;
  }

}
