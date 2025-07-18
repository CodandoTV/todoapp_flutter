import 'package:flutter/material.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

import '../components/form_validator.dart';

class TaskFormWidget extends StatelessWidget {
  final Key formKey;
  final TextEditingController taskEditingController;
  final FormScreenValidator formScreenValidator;

  const TaskFormWidget({
    super.key,
    required this.formKey,
    required this.taskEditingController,
    required this.formScreenValidator,
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
            controller: taskEditingController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.task,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (formScreenValidator.validateValue(value) == false) {
                return AppLocalizations.of(context)!.task_name_required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
