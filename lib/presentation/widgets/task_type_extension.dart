import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/task/task_cell.dart';
import '../../domain/model/task.dart';
import '../../domain/model/task_type.dart';

extension TaskTypeExtension on TaskType {
  IconData toIcon() {
    switch (this) {
      case TaskType.pet:
        return Icons.pets;
      case TaskType.supermarket:
        return Icons.shop;
      case TaskType.chores:
        return Icons.house;
      case TaskType.unknown:
        return Icons.help;
    }
  }
}

extension TaskExtension on Task {
  TaskCell toTaskCell() {
    return TaskCell(
      task: this,
      isSelected: false,
      icon: type.toIcon(),
    );
  }
}
