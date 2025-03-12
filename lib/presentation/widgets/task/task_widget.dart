import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/task/task_cell.dart';

class TaskWidget extends StatelessWidget {
  final TaskCell cell;
  final Function(bool?) onCheckChanged;
  final VoidCallback onLongPress;

  const TaskWidget({
    super.key,
    required this.cell,
    required this.onCheckChanged,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
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
          leading: SizedBox(
            height: 48,
            width: 48,
            child: Icon(cell.icon),
          ),
          subtitle: cell.task.desc != null
              ? Text(
                  cell.task.desc!,
                  style: TextStyle(
                    decoration: cell.task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                )
              : null,
          trailing: Checkbox(
            value: cell.task.isCompleted,
            onChanged: onCheckChanged,
          ),
        ),
      ),
    );
  }
}
