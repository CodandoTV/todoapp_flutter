import 'package:flutter/material.dart';

class TaskTitleWidget extends StatelessWidget {
  final String taskTitle;
  final bool isComplete;

  const TaskTitleWidget({
    super.key,
    required this.taskTitle,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      taskTitle,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            decoration:
                isComplete ? TextDecoration.lineThrough : TextDecoration.none,
            fontStyle: isComplete ? FontStyle.italic : FontStyle.normal,
          ),
    );
  }
}
