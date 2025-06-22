import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/trailing_icon_type.dart';
import '../../data/model/task.dart';

extension TaskTypeExtension on String {
  IconData toIcon() {
    switch (this) {
      case 'Pet':
        return Icons.pets;
      case 'Supermarket':
        return Icons.shop;
      case 'Chores':
        return Icons.house;
      default:
        return Icons.help;
    }
  }
}

extension TaskExtension on Task {
  TaskCell toTaskCell(bool isSelected) {
    return TaskCell(
      task: this,
      isSelected: isSelected,
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
