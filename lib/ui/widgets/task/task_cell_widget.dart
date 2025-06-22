import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/task_title_widget.dart';

class TaskCellWidget extends StatelessWidget {
  final TaskCell cell;
  final Function(bool?) onCheckChanged;
  final VoidCallback onLongPress;

  const TaskCellWidget({
    super.key,
    required this.cell,
    required this.onCheckChanged,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    const cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    return Card(
      child: InkWell(
        onLongPress: onLongPress,
        customBorder: cardShape,
        child: ListTile(
          shape: cardShape,
          title: TaskTitleWidget(
            taskTitle: cell.task.title,
            isComplete: cell.task.isCompleted,
          ),
          leading: Checkbox(
            value: cell.task.isCompleted,
            onChanged: onCheckChanged,
          ),
          trailing: cell.isSelected
              ? const Icon(Icons.check_circle)
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
