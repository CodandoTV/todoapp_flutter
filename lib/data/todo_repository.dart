import 'package:injectable/injectable.dart';
import 'package:todoapp/data/database/task_dao.dart';
import 'model/task.dart';

abstract class TodoRepository {
  Future<List<Task>> getTasks();
  Future<bool> update(Task task, bool isCompletedNewValue);
  Future<bool> add(Task task);
  Future<bool> delete(List<Task> tasks);
  Future<void> updateAll(List<Task> tasks);
}

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TaskDAO _todoDAO;

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

  @override
  Future<void> updateAll(List<Task> tasks) {
    return _todoDAO.updateAll(tasks);
  }
}
