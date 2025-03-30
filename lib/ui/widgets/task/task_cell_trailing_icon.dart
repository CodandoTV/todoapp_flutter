import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task/trailing_icon_type.dart';

class TaskCellTrailingIcon extends StatelessWidget {
  final TrailingIconType type;
  final Function(bool?) onCheckChanged;

  const TaskCellTrailingIcon(
      {super.key, required this.type, required this.onCheckChanged});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TrailingIconType.selected:
        return const Icon(Icons.check_circle);
      case TrailingIconType.notCompleted:
        return Checkbox(
          value: false,
          onChanged: onCheckChanged,
        );
      case TrailingIconType.completed:
        return Checkbox(
          value: true,
          onChanged: onCheckChanged,
        );
    }
  }
}
