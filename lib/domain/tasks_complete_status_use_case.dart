import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';

abstract class TasksCompleteStatusUseCase {
  TasksCompleteStatus checkStatus(List<Task> tasks);
}

@Injectable(as: TasksCompleteStatusUseCase)
class TasksCompleteStatusUseCaseImpl implements TasksCompleteStatusUseCase {
  @override
  TasksCompleteStatus checkStatus(List<Task> tasks) {
    final areAllCompleted =
        tasks.where((task) => task.isCompleted).length == tasks.length;

    if (areAllCompleted) {
      return TasksCompleteStatus.uncheckAll;
    } else {
      return TasksCompleteStatus.checkAll;
    }
  }
}
