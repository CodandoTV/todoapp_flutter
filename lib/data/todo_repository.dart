import 'package:todoapp/data/database/todo_dao.dart';
import 'model/task.dart';

mixin TodoRepository {
  Future<List<Task>> getTasks();
  Future<bool> update(Task task, bool isCompletedNewValue);
  Future<bool> add(Task task);
  Future<bool> delete(List<Task> tasks);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoDAO _todoDAO;

  TodoRepositoryImpl(this._todoDAO);

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
}
