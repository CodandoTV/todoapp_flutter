import 'package:flutter/material.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/widgets/card_wrapper_widget.dart';
import 'package:todoapp/ui/components/widgets/task/task_title_widget.dart';

class TaskCellWidget extends StatelessWidget {
  static const checkboxKey = 'TaskCellWidget_Checkbox';

  final Task task;
  final Function(bool?) onCheckChanged;
  final Function(Task) onRemoveTask;
  final Function() onTap;

  const TaskCellWidget({
    super.key,
    required this.task,
    required this.onCheckChanged,
    required this.onRemoveTask,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardWrapperWidget(
      elevation: CardWrapperWidget.commonElevation,
      shapeBorder: CardWrapperWidget.commonShapeBorder,
      onTap: null,
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      child: ListTile(
        leading: IconButton(
          onPressed: () => {onRemoveTask(task)},
          icon: const Icon(Icons.close),
        ),
        title: TaskTitleWidget(
          taskTitle: task.title,
          isComplete: task.isCompleted,
        ),
        onTap: onTap,
        trailing: Checkbox(
          key: const Key(checkboxKey),
          value: task.isCompleted,
          onChanged: onCheckChanged,
        ),
      ),
    );
  }
}
