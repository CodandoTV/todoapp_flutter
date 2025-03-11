import 'package:todo_app/domain/model/task_type.dart';

class GetCategoriesUseCase {
  List<String> get() {
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
