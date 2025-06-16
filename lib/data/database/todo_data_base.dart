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

class TodoDataBase {
  late Database _dataBase;

  TodoDataBase(this._dataBase);

  Future<int> insert(String tableName, Map<String, Object?> values) async {
    try {
      return await _dataBase.insert(tableName, values);
    } catch (exception) {
      return -1;
    }
  }

  Future<List<Map<String, Object?>>> query(String tableName) async {
    try {
      return await _dataBase.query(tableName);
    } catch (exception) {
      return [];
    }
  }

  Future<int> update(
      String tableName, Map<String, Object?> values, String where) async {
    try {
      return await _dataBase.update(tableName, values, where: where);
    } catch (exception) {
      return -1;
    }
  }

  Future<int> delete(String tableName, String where) async {
    try {
      return await _dataBase.delete(tableName, where: where);
    } catch (exception) {
      return -1;
    }
  }
}
