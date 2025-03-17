import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/task.dart';

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
  List<Object?> get props => [task, isSelected, icon];

  TaskCell copy({Task? task, bool? isSelected, IconData? icon}) {
    return TaskCell(
      task: task ?? this.task,
      isSelected: isSelected ?? this.isSelected,
      icon: icon ?? this.icon,
    );
  }
}
