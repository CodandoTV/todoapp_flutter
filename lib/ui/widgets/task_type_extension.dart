import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/trailing_icon_type.dart';
import '../../data/model/task.dart';
import '../../data/model/task_type.dart';

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
  TaskCell toTaskCell(bool isSelected) {
    return TaskCell(
      task: this,
      isSelected: isSelected,
      icon: type.toIcon(),
    );
  }
}

extension TaskCellExtension on TaskCell {
  TrailingIconType toRightIconType() {
    if (isSelected) {
      return TrailingIconType.selected;
    } else {
      if (task.isCompleted) {
        return TrailingIconType.completed;
      } else {
        return TrailingIconType.notCompleted;
      }
    }
  }
}
