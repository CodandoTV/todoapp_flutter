import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/database/task_dao.dart';

const String dataBaseName = 'todo_data_base.db';

class DataBaseBuilder {
  static Future<Database> build() async {
    Database dataBase = await openDatabase(
      dataBaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          TaskDAO.createTableQuery,
        );
      },
    );
    return dataBase;
  }
}
