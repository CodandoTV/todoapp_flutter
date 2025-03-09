import 'package:todo_app/domain/model/task.dart';
import 'package:todo_app/domain/model/task_type.dart';

class TodoRepository {
  Future<List<Task>> getTasks() async {
    return [
      Task(
        title: 'Buy guinea pig food',
        type: TaskType.pet,
        desc: 'Should buy megazoo',
      ),
      Task(title: 'Buy dog food', type: TaskType.pet, desc: null),
      Task(title: 'Wash the dishes', type: TaskType.chores, desc: null),
    ];
  }
}
