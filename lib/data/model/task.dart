
import 'package:todo_app/data/model/task_type.dart';

class Task {
  String title;
  String? desc;
  TaskType type;
  bool isCompleted;

  Task({
    required this.title,
    required this.desc,
    required this.type,
    required this.isCompleted
  });
}
