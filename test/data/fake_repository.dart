import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/todo_repository.dart';

class FakeRepository implements TodoRepository {
  List<Task> _data = [];

  FakeRepository(List<Task> data) {
    _data = data;
  }

  @override
  Future<bool> add(Task task) async {
    _data.add(task);
    return Future.value(true);
  }

  @override
  Future<bool> delete(List<Task> tasks) async {
    for (var task in tasks) {
      _data.remove(task);
    }
    return Future.value(true);
  }

  @override
  Future<List<Task>> getTasks() async {
    return Future.value(_data);
  }

  @override
  Future<List<String>> taskCategories() async {
    return Future.value(['Work', 'Personal']);
  }

  @override
  Future<bool> update(Task task, bool isCompletedNewValue) async {
    final index = _data.indexOf(task);
    if (index != -1) {
      _data[index] = task.copyWithIsComplete(isCompleted: isCompletedNewValue);
      return Future.value(true);
    }
    return Future.value(false);
  }
}
