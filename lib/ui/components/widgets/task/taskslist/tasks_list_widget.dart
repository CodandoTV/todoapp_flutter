import 'package:flutter/material.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/widgets/task/task_cell_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class TasksListWidget extends StatelessWidget {
  final List<Task> tasks;
  final int? flex;
  final Function(Task) onRemoveTask;
  final Function(Task p1, bool p2) onCompleteTask;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(Task) onTap;

  const TasksListWidget({
    super.key,
    required this.tasks,
    this.flex,
    required this.onRemoveTask,
    required this.onCompleteTask,
    required this.onReorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTaskList(context);
  }

  Widget _buildTaskList(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final emptyTaskMessage = localizations.empty_tasks;

    Widget child;
    if (tasks.isEmpty) {
      child = Center(
        child: Text(
          emptyTaskMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      child = ReorderableListView.builder(
        onReorder: onReorder,
        padding: const EdgeInsets.only(
          bottom: 120.0,
        ),
        itemBuilder: (context, index) => _buildTaskCellWidget(
          tasks[index],
        ),
        itemCount: tasks.length,
      );
    }

    return Expanded(
      flex: flex ?? 1,
      child: child,
    );
  }

  TaskCellWidget _buildTaskCellWidget(Task task) {
    return TaskCellWidget(
      key: ValueKey(task.id),
      task: task,
      onRemoveTask: onRemoveTask,
      onCheckChanged: (value) => onCompleteTask(task, value ?? false),
      onTap: () => onTap(task),
    );
  }
}
