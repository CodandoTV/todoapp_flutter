import 'package:flutter/cupertino.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/task_cell_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return _buildTaskList(context);
  }

  Widget _buildTaskList(BuildContext context) {
    if (taskUiModels.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.empty_tasks,
        ),
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
