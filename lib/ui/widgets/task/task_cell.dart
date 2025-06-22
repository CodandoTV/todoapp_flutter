import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/task.dart';

@immutable
class TaskCell extends Equatable {
  final Task task;
  final bool isSelected;

  const TaskCell({
    required this.task,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [
        task,
        isSelected,
      ];

  TaskCell copyWithTask(task) {
    return TaskCell(
      task: task,
      isSelected: isSelected,
    );
  }

  TaskCell copyWithIsSelected(isSelected) {
    return TaskCell(
      task: task,
      isSelected: isSelected,
    );
  }
}
