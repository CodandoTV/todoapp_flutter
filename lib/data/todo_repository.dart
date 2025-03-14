import 'package:todo_app/data/todo_in_memory_data_source.dart';
import 'package:todo_app/domain/model/task.dart';

class TodoRepository {
  final TodoInMemoryDataSource _todoInMemoryDataSource;

  TodoRepository(this._todoInMemoryDataSource);

  Future<List<Task>> getTasks() async {
    return _todoInMemoryDataSource.getTasks();
  }

  Future<bool> update(Task task, bool isCompletedNewValue) async {
    return _todoInMemoryDataSource.update(task, isCompletedNewValue);
  }

  Future<bool> add(Task task) async {
    return _todoInMemoryDataSource.add(task);
  }

  Future<bool> delete(List<Task> tasks) async {
    return _todoInMemoryDataSource.delete(tasks);
  }
}
