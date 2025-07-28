import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_title_widget.dart';

import '../../../data/model/task.dart';

class TaskCellWidget extends StatelessWidget {
  final Task task;
  final Function(bool?) onCheckChanged;
  final Function(Task) onRemoveTask;

  const TaskCellWidget({
    super.key,
    required this.task,
    required this.onCheckChanged,
    required this.onRemoveTask,
  });

  @override
  Widget build(BuildContext context) {
    const cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    String checkboxKeyValue = task.isCompleted
        ? 'TaskCellWidget_Completed'
        : 'TaskCellWidget_NotCompleted';

    return Card(
      elevation: 4,
      shape: cardShape,
      child: ListTile(
        leading: IconButton(
          onPressed: () => {onRemoveTask(task)},
          icon: const Icon(Icons.close),
        ),
        title: TaskTitleWidget(
          taskTitle: task.title,
          isComplete: task.isCompleted,
        ),
        trailing: Checkbox(
          key: Key(checkboxKeyValue),
          value: task.isCompleted,
          onChanged: onCheckChanged,
        ),
      ),
    );
  }
}
