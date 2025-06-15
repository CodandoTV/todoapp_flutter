import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/task.dart';

@immutable
class TaskCell extends Equatable {
  final Task task;
  final bool isSelected;
  final IconData icon;

  const TaskCell({
    required this.task,
    required this.isSelected,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        task,
        isSelected,
        icon,
      ];

  TaskCell copyWithTask(task) {
    return TaskCell(
      task: task,
      isSelected: isSelected,
      icon: icon,
    );
  }

  TaskCell copyWithIsSelected(isSelected) {
    return TaskCell(
      task: task,
      isSelected: isSelected,
      icon: icon,
    );
  }
}
