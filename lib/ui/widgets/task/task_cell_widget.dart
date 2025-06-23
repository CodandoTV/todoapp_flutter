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

    return Card(
      child: InkWell(
        customBorder: cardShape,
        child: ListTile(
          shape: cardShape,
          title: TaskTitleWidget(
            taskTitle: task.title,
            isComplete: task.isCompleted,
          ),
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: onCheckChanged,
          ),
          trailing: IconButton(
              onPressed: () => {onRemoveTask(task)},
              icon: const Icon(Icons.close)),
        ),
      ),
    );
  }
}
