import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/task/task_cell_trailing_icon.dart';
import 'package:todoapp/ui/widgets/task_type_extension.dart';

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
            trailing: TaskCellTrailingIcon(
                type: cell.toRightIconType(), onCheckChanged: onCheckChanged)),
      ),
    );
  }
}
