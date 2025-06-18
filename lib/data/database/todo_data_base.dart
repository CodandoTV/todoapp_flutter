import 'package:sqflite/sqflite.dart';

class TodoDataBase {
  late final Database _dataBase;

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
