import 'package:flutter/material.dart';
import 'package:todoapp/ui/generated/app_localizations.dart';
import 'package:todoapp/ui/widgets/task/task_cell_widget.dart';

import '../../../data/model/task.dart';

class TasksListWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onRemoveTask;
  final Function(Task p1, bool p2) onCompleteTask;
  final Function(int oldIndex, int newIndex) onReorder;

  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.onRemoveTask,
    required this.onCompleteTask,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTaskList(context);
  }

  Widget _buildTaskList(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.empty_tasks,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      final children = tasks
          .map((task) => TaskCellWidget(
                key: ValueKey(task.id),
                task: task,
                onRemoveTask: onRemoveTask,
                onCheckChanged: (value) => onCompleteTask(task, value ?? false),
              ))
          .toList();
      return ReorderableListView(
        onReorder: onReorder,
        padding: const EdgeInsets.only(
            bottom: 120
        ),
        children: children,
      );
    }
  }
}
