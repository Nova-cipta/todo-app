import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/util/static.dart';

class DatabaseClient {
  /// set up & initiate sqflite [Database]
  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$dbName.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade
    );
    return db;
  }

  void _onUpgrade(Database db, int before, int after) {
    if (before < after) {
      db.delete(tbTodo);
      _onCreate(db, after);
    }
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tbTodo (
        id INTEGER PRIMARY KEY,
        title TEXT,
        assigned_to TEXT,
        is_done INTEGER,
        date Text
      );
    ''');
  }
}