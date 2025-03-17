import 'model/task.dart';

class TodoInMemoryDataSource {
  late List<Task> _tasks;

  TodoInMemoryDataSource(List<Task> tasks) {
    _tasks = tasks;
  }

  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  Future<bool> update(Task task, bool isCompletedNewValue) async {
    var index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isCompleted = isCompletedNewValue;
      return true;
    }
    return false;
  }

  Future<bool> add(Task task) async {
    _tasks.add(task);
    return true;
  }

  Future<bool> delete(List<Task> tasks) async {
    for (var task in tasks) {
      _tasks.remove(task);
    }
    return true;
  }
}
