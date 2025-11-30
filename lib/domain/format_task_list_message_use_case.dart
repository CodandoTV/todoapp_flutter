import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class FormatTaskListMessageUseCase {
  String formatTaskList({required List<Task> tasks});
}

@Injectable(as: FormatTaskListMessageUseCase)
class FormatTaskListMessageUseCaseImpl extends FormatTaskListMessageUseCase {
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
}
