import 'package:flutter/widgets.dart';

import '../../../domain/model/task.dart';

class TaskCell {
  Task task;
  bool isSelected;
  IconData icon;

  TaskCell({
    required this.task,
    required this.isSelected,
    required this.icon,
  });
}
