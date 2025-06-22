import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';

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
    return Card(
      child: InkWell(
        onLongPress: onLongPress,
        child: ListTile(
          title: Text(
            cell.task.title,
            style: TextStyle(
              decoration: cell.task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
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
