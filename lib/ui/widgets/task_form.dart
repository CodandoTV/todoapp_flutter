import 'package:flutter/material.dart';
import '../screens/task/task_screen_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskForm extends StatelessWidget {
  final Key formKey;
  final TextEditingController taskEditingController;
  final TaskScreenValidator taskScreenValidator;
  final List<String> categoryNames;

  const TaskForm({
    required this.formKey,
    required this.taskEditingController,
    required this.taskScreenValidator,
    required this.categoryNames,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: taskEditingController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.task,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (taskScreenValidator.validateTaskName(value) == false) {
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
