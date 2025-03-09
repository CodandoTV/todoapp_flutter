import 'package:todo_app/domain/model/task_type.dart';

class Task {
  String title;
  String? desc;
  TaskType type;

  Task({
    required this.title,
    required this.desc,
    required this.type,
  });
}
