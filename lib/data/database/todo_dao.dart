import 'package:todoapp/data/database/todo_data_base.dart';
import 'package:todoapp/data/model/task.dart';

class TodoDAO {
  static const tableName = 'Todo';
  static const idKey = 'id';
  static const titleKey = 'title';
  static const descKey = 'desc';
  static const typeKey = 'type';
  static const isCompletedKey = 'isCompleted';

  static const createTableQuery = 'CREATE TABLE ${TodoDAO.tableName} ('
      '${TodoDAO.idKey} INTEGER PRIMARY KEY, '
      '${TodoDAO.titleKey} TEXT, '
      '${TodoDAO.descKey} TEXT, '
      '${TodoDAO.typeKey} TEXT, '
      '${TodoDAO.isCompletedKey} INTEGER'
      ')';

  late TodoDataBase _database;

  TodoDAO(TodoDataBase database) {
    _database = database;
  }

  Future<List<Task>> getAll() async {
    final result = await _database.query(tableName);
    return result
        .map(
          (e) => Task(
            id: e[idKey] as int,
            title: e[titleKey] as String,
            desc: e[descKey] as String,
            type: e[typeKey] as String,
            isCompleted: (e[isCompletedKey] as int?) == 1,
          ),
        )
        .toList();
  }

  _taskToValues(Task task) {
    return {
      idKey: task.id,
      titleKey: task.title,
      descKey: task.desc,
      typeKey: task.type,
      isCompletedKey: task.isCompleted ? 1 : 0
    };
  }

  Future<bool> update(Task task, bool isCompletedNewValue) async {
    final values = {isCompletedKey: isCompletedNewValue ? 1 : 0};

    final result =
        await _database.update(tableName, values, '$idKey = ${task.id}');
    return result == 1 ? true : false;
  }

  Future<bool> delete(List<Task> tasks) async {
    final result = await _database.delete(
        tableName, '$idKey IN (${tasks.map((e) => e.id).join(',')})');
    return result == 1 ? true : false;
  }

  Future<bool> add(Task task) async {
    final result = await _database.insert(tableName, _taskToValues(task));
    return result == 1 ? true : false;
  }
}
