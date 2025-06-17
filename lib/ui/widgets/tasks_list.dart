import 'package:flutter/cupertino.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/task_cell_widget.dart';

class TasksList extends StatelessWidget {
  final List<TaskCell> taskUiModels;
  final Function onRemoveTask;
  final Function(TaskCell p1, bool p2) onCompleteTask;

  const TasksList({
    super.key,
    required this.taskUiModels,
    required this.onRemoveTask,
    required this.onCompleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTaskList();
  }

  Widget _buildTaskList() {
    if (taskUiModels.isEmpty) {
      return const Center(
        child: Text('No tasks'),
      );
    } else {
      return ListView.builder(
        itemCount: taskUiModels.length,
        itemBuilder: (context, index) {
          var taskCell = taskUiModels[index];
          return TaskCellWidget(
            onLongPress: () => {onRemoveTask(taskCell.task)},
            onCheckChanged: (value) => {
              onCompleteTask(
                taskCell,
                value ?? false,
              )
            },
            cell: taskCell,
          );
        },
      );
    }
  }
}
