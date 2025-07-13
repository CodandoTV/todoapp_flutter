import 'package:injectable/injectable.dart';

import '../data/model/task.dart';

@Injectable()
class CalculateTaskProgressUseCase {
  double execute({required List<Task> tasks}) {
    int completedTasks = 0;
    for (var task in tasks) {
      if (task.isCompleted) {
        completedTasks++;
      }
    }

    return completedTasks / tasks.length.toDouble();
  }
}
