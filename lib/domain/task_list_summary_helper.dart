import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';

abstract class TaskListSummaryHelper {
  bool shouldShowShareButton({required List<Task> tasks});
  double calculateProgress({required List<Task> tasks});
  String formatTaskList({required List<Task> tasks});
  TasksCompleteStatus? checkStatus({required List<Task> tasks});
}

@Injectable(as: TaskListSummaryHelper)
class TaskListSummaryHelperImpl extends TaskListSummaryHelper {
  @override
  double calculateProgress({required List<Task> tasks}) {
    int completedTasks = 0;
    for (var task in tasks) {
      if (task.isCompleted) {
        completedTasks++;
      }
    }

    if (tasks.isNotEmpty) {
      return completedTasks / tasks.length.toDouble();
    } else {
      return 0.0;
    }
  }

  @override
  String formatTaskList({required List<Task> tasks}) {
    var checklist = '';

    for (var task in tasks) {
      if (task.isCompleted == false) {
        checklist += '- ${task.title}\n';
      }
    }
    return checklist;
  }

  @override
  bool shouldShowShareButton({required List<Task> tasks}) {
    return tasks.any((task) => task.isCompleted == false);
  }

  @override
  TasksCompleteStatus? checkStatus({required List<Task> tasks}) {
    if (tasks.isEmpty) {
      return null;
    } else {
      final areAllCompleted =
          tasks.where((task) => task.isCompleted).length == tasks.length;

      if (areAllCompleted) {
        return TasksCompleteStatus.uncheckAll;
      } else {
        return TasksCompleteStatus.checkAll;
      }
    }
  }
}
