import 'package:todo_app/data/todo_in_memory_data_source.dart';

import 'model/task.dart';
import 'model/task_type.dart';

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

  List<String> getCategories() {
    var tasks = TaskType.values.toList();
    tasks.sort(_compare);
    return tasks.map((toElement) => toElement.name).toList();
  }

  int _compare(TaskType a, TaskType b) {
    if (a == TaskType.unknown) {
      return -1;
    } else {
      return 1;
    }
  }
}
