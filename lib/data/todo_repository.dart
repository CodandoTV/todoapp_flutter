import 'package:todoapp/data/database/todo_category_dao.dart';
import 'package:todoapp/data/database/todo_dao.dart';
import 'model/task.dart';

mixin TodoRepository {
  Future<List<Task>> getTasks();
  Future<bool> update(Task task, bool isCompletedNewValue);
  Future<bool> add(Task task);
  Future<bool> delete(List<Task> tasks);
  Future<List<String>> taskCategories();
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoDAO _todoDAO;
  final TodoCategoryDAO _categoryDAO;

  TodoRepositoryImpl(this._todoDAO, this._categoryDAO);

  @override
  Future<List<Task>> getTasks() async {
    return _todoDAO.getAll();
  }

  @override
  Future<bool> update(Task task, bool isCompletedNewValue) async {
    return _todoDAO.update(task, isCompletedNewValue);
  }

  @override
  Future<bool> add(Task task) async {
    return _todoDAO.add(task);
  }

  @override
  Future<bool> delete(List<Task> tasks) async {
    return _todoDAO.delete(tasks);
  }

  @override
  Future<List<String>> taskCategories() async {
    return _categoryDAO.getCategories();
  }
}
