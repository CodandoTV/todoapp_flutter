import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String title;
  final String? desc;
  final bool isChecked;
  final IconData icon;
  final Function(bool?) onCheckChanged;

  const TaskWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.isChecked,
    required this.icon,
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
      leading: SizedBox(
        height: 48,
        width: 48,
        child: Icon(icon),
      ),
      subtitle: desc != null
          ? Text(
              desc!,
              style: TextStyle(
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            )
          : null,
      trailing: Checkbox(
        value: isChecked,
        onChanged: onCheckChanged,
      ),
    ));
  }
}
