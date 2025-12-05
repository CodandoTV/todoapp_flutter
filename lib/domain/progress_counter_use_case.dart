import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class ProgressCounterUseCase {
  double calculateProgress({required List<Task> tasks});
}

@Injectable(as: ProgressCounterUseCase)
class ProgressCounterUseCaseImpl extends ProgressCounterUseCase {
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
}
