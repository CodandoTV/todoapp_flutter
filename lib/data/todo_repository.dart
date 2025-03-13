import 'package:todo_app/domain/model/task.dart';
import 'package:todo_app/domain/model/task_type.dart';

class TodoRepository {
  final List<Task> _tasks = [
    Task(
      title: 'Buy guinea pig food',
      type: TaskType.pet,
      desc: 'Should buy megazoo',
      isCompleted: false,
    ),
    Task(
        title: 'Buy dog food',
        type: TaskType.pet,
        desc: null,
        isCompleted: false),
    Task(
        title: 'Wash the dishes',
        type: TaskType.chores,
        desc: null,
        isCompleted: false),
  ];

  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  Future<bool> update(Task task, bool isCompletedNewValue) async {
    var index = _tasks.indexOf(task);
    if (index != -1) {
      var task = _tasks[index];
      _tasks[index] = Task(
        title: task.title,
        desc: task.desc,
        type: task.type,
        isCompleted: isCompletedNewValue,
      );
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
