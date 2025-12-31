import 'package:flutter/material.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/widgets/task/task_cell_widget.dart';

class TasksListWidget extends StatelessWidget {
  final List<Task> tasks;
  final String emptyTasksMessage;
  final Function(Task) onRemoveTask;
  final Function(Task p1, bool p2) onCompleteTask;
  final Function(int oldIndex, int newIndex) onReorder;
  final Function(Task) onTap;

  const TasksListWidget({
    super.key,
    required this.tasks,
    required this.emptyTasksMessage,
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
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          emptyTasksMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      return ReorderableListView.builder(
        onReorder: onReorder,
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 120,
        ),
        itemBuilder: (context, index) => _buildTaskCellWidget(
          tasks[index],
        ),
        itemCount: tasks.length,
      );
    }
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
