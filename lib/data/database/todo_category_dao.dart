import 'package:todoapp/data/database/todo_data_base.dart';

class TodoCategoryDAO {
  static const tableName = 'TaskCategory';
  static const idKey = 'id';
  static const descKey = 'desc';

  static const List<Map<String, Object?>> defaultValues = [
    {
      idKey: 1,
      descKey: 'Pet',
    },
    {
      idKey: 2,
      descKey: 'Supermarket',
    },
    {
      idKey: 3,
      descKey: 'Chores',
    },
    {
      idKey: 4,
      descKey: 'Unknown',
    },
  ];

  static const createTableQuery = 'CREATE TABLE $tableName ('
      '$idKey INTEGER PRIMARY KEY, '
      '$descKey TEXT'
      ')';

  late TodoDataBase _database;

  TodoCategoryDAO(TodoDataBase database) {
    _database = database;
  }

  Future<List<String>> getCategories() async {
    try {
      final result = await _database.query(tableName);
      return result.map((e) => e[descKey].toString()).toList();
    } catch (exception) {
      return [];
    }
  }
}
