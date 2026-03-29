import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class TaskListSortHelper {
  bool areThemEqual({required List<Task> oldList, required List<Task> newList});
  List<Task> sortByCompletedStatus(List<Task> tasks);
}

@Injectable(as: TaskListSortHelper)
class TaskListSortHelperImpl extends TaskListSortHelper {
  @override
  bool areThemEqual({
    required List<Task> oldList,
    required List<Task> newList,
  }) {
    if (oldList.length == newList.length) {
      if (oldList.isEmpty && newList.isEmpty) {
        return true;
      } else {
        for (var i = 0; i < oldList.length; i++) {
          if (oldList[i] == newList[i]) {
            continue;
          } else {
            return false;
          }
        }
      }
    } else {
      return false;
    }
    return true;
  }

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
