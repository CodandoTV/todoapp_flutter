import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../screens/task/task_screen_validator.dart';

class ChecklistFormWidget extends StatelessWidget {
  final Key formKey;
  final TextEditingController checklistEditingController;

  const ChecklistFormWidget({
    super.key,
    required this.formKey,
    required this.checklistEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: checklistEditingController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.task,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return AppLocalizations.of(context)!.checklist_name_required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
