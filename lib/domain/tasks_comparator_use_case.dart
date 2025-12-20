import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class TasksComparatorUseCase {
  bool areThemEqual({required List<Task> oldList, required List<Task> newList});
}

@Injectable(as: TasksComparatorUseCase)
class TasksComparatorUseCaseImpl extends TasksComparatorUseCase {
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
}
