// create the results table
class BMICreateTableQuery {
  static const String createTableQuery = '''
    CREATE TABLE results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      age INTEGER,
      weight REAL,
      height REAL,
      bmi REAL,
      status TEXT
    )
  ''';
}
