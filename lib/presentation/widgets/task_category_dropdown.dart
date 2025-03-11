import 'package:flutter/material.dart';

class TaskCategoryDropdown extends StatelessWidget {
  final String initialValue;
  final List<String> values;
  final ValueChanged<String?> onChanged;

  const TaskCategoryDropdown({
    super.key,
    required this.initialValue,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      decoration: const InputDecoration(
        labelText: "Type",
        border: OutlineInputBorder(),
      ),
      items: values
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
