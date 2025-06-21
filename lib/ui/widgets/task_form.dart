import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/widgets/task_category_dropdown.dart';
import '../screens/task/task_screen_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskForm extends StatelessWidget {
  final Key formKey;
  final TextEditingController taskEditingController;
  final TextEditingController descriptionEditingController;
  final Function(String?) onCategoryChanged;
  final TaskScreenValidator taskScreenValidator;
  final List<String> categoryNames;

  const TaskForm({
    required this.formKey,
    required this.taskEditingController,
    required this.descriptionEditingController,
    required this.onCategoryChanged,
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
          const SizedBox(height: 20),
          TextFormField(
            controller: descriptionEditingController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.description,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TaskCategoryDropdown(
            values: categoryNames,
            onChanged: onCategoryChanged,
            validator: (value) {
              if (taskScreenValidator.validateTaskType(value) == false) {
                return AppLocalizations.of(context)!.task_type_required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
