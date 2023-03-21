import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bmi_calculator/models/result.dart';
import 'package:bmi_calculator/queries/bmi_create_table_query.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  // priv constructor to create a singleton instance of the DatabaseHelper class
  DatabaseHelper._internal();

  // getter method to access the database instance asynchronously
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    // if database instance is null, initialize the database
    _database = await initDatabase();
    return _database;
  }

  // initialize the database
  Future<Database> initDatabase() async {
    // Get the path to the database file
    String path = await getDatabasesPath();
    path = join(path, 'BMI.db');

    // open the database and create the table if it doesn't exist
    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(BMICreateTableQuery.createTableQuery);
    });
    // return openDatabase(path, version: 1, onCreate: _createTableQuery);
  }

  // Insert a new result into the database
  Future<int> insertResult(Result result) async {
    final db = await instance.database;
    return db!.insert('results', result.toMapWithoutId());
  }

  // Retrieve all the results from the database
  Future<List<Result>> getResults() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db?.query('results') ?? [];
    return List.generate(maps.length, (i) {
      return Result.fromMap(maps[i]);
    });
  }

  // Delete a result from the database
  Future<int> deleteResult(int id) async {
    final db = await instance.database;
    return db!.delete('results', where: 'id = ?', whereArgs: [id]);
  }

  // Retrieve all results from the database
  Future<List<Result>> queryAllResults() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db!.query('results', orderBy: 'id DESC');
      return List.generate(maps.length, (i) {
        return Result(
          id: maps[i]['id'],
          weight: maps[i]['weight'],
          height: maps[i]['height'],
          age: maps[i]['age'],
          bmi: maps[i]['bmi'],
          status: maps[i]['status'],
        );
      });
    } catch (e) {
      print('Error querying results: $e');
      return [];
    }
  }
}