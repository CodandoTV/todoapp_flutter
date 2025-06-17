import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/database/todo_category_dao.dart';
import 'package:todoapp/data/database/todo_dao.dart';

const String dataBaseName = 'todo_data_base.db';

class DataBaseBuilder {
  static Future<Database> build() async {
    Database dataBase = await openDatabase(
      dataBaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          TodoDAO.createTableQuery,
        );

        await db.execute(
          TodoCategoryDAO.createTableQuery,
        );

        for (var value in TodoCategoryDAO.defaultValues) {
          await db.insert(TodoCategoryDAO.tableName, value);
        }
      },
    );
    return dataBase;
  }
}
