import 'package:todo_app/domain/model/task.dart';

class TaskUiModel {
  final Task task;
  final bool isChecked;

  TaskUiModel({
    required this.task,
    required this.isChecked,
  });
}
