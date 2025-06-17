import 'package:todoapp/data/database/todo_category_dao.dart';
import 'package:todoapp/data/database/todo_dao.dart';
import 'model/task.dart';

class TodoRepository {
  final TodoDAO _todoDAO;
  final TodoCategoryDAO _categoryDAO;

  TodoRepository(this._todoDAO, this._categoryDAO);

  Future<List<Task>> getTasks() async {
    return _todoDAO.getAll();
  }

  Future<bool> update(Task task, bool isCompletedNewValue) async {
    return _todoDAO.update(task, isCompletedNewValue);
  }

  Future<bool> add(Task task) async {
    return _todoDAO.add(task);
  }

  Future<bool> delete(List<Task> tasks) async {
    return _todoDAO.delete(tasks);
  }

  Future<List<String>> taskCategories() async {
    return _categoryDAO.getCategories();
  }
}
