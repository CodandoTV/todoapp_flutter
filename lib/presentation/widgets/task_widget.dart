import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String title;
  final String? desc;
  final bool isChecked;
  final Function(bool?) onCheckChanged;

  const TaskWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.isChecked,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        desc ?? "",
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onCheckChanged,
      ),
    ));
  }
}
