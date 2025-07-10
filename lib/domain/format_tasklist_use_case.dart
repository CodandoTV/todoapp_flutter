import 'package:injectable/injectable.dart';

import '../data/model/task.dart';

enum FormatMode {
  allTasks,
  onlyNotCompleted,
}

@Injectable()
class FormatTaskListUseCase {
  String execute({
    required List<Task> tasks,
    required FormatMode formatMode,
  }) {
    var checklist = '';

    for (var task in tasks) {
      switch (formatMode) {
        case FormatMode.allTasks:
          checklist += '- ${task.title}\n';
        case FormatMode.onlyNotCompleted:
          if (task.isCompleted == false) {
            checklist += '- ${task.title}\n';
          }
      }
    }

    return checklist;
  }
}
