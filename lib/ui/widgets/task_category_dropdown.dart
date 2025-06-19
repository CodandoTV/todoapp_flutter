import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskCategoryDropdown extends StatelessWidget {
  final List<String> values;
  final ValueChanged<String?> onChanged;

  const TaskCategoryDropdown({
    super.key,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      hint: Text(AppLocalizations.of(context)!.select_category),
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.task_category,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
