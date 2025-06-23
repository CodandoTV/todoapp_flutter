import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/model/task.dart';

class TasksListWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onRemoveTask;
  final Function(Task p1, bool p2) onCompleteTask;

  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.onRemoveTask,
    required this.onCompleteTask,
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
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var taskCell = tasks[index];
          return TaskCellWidget(
            onRemoveTask: onRemoveTask,
            onCheckChanged: (value) => {
              onCompleteTask(
                taskCell,
                value ?? false,
              )
            },
            task: taskCell,
          );
        },
      );
    }
  }
}
