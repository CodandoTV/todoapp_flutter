import 'package:injectable/injectable.dart';

import '../data/model/task.dart';

@Injectable()
class FormatTaskListUseCase {
  String execute({
    required List<Task> tasks,
  }) {
    var checklist = '';

    for (var task in tasks) {
      if (task.isCompleted == false) {
        checklist += '- ${task.title}\n';
      }
    }
    return checklist;
  }
}
