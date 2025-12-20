import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class TasksSorterUseCase {
  List<Task> sortByCompletedStatus(List<Task> tasks);
}

@Injectable(as: TasksSorterUseCase)
class TasksSorterUseCaseImpl implements TasksSorterUseCase {
  @override
  List<Task> sortByCompletedStatus(List<Task> tasks) {
    List<Task> tasksToBeSorted = List.from(tasks);
    tasksToBeSorted.sort((a, b) => _sort(a, b));
    return tasksToBeSorted;
  }

  int _sort(Task a, Task b) {
    if (a.isCompleted == false && b.isCompleted) {
      return -1;
    } else if (a.isCompleted && b.isCompleted == false) {
      return 1;
    } else {
      return 0;
    }
  }
}