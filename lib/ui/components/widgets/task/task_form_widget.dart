import 'package:flutter/material.dart';

import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/components/widgets/form/form_field_widget.dart';

class TaskFormWidget extends StatelessWidget {
  final Key formKey;
  final String taskLabel;
  final String taskErrorMessage;
  final TextEditingController taskEditingController;
  final FormScreenValidator formScreenValidator;

  const TaskFormWidget({
    super.key,
    required this.taskLabel,
    required this.taskErrorMessage,
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
          FormFieldWidget(
            labelText: taskLabel,
            controller: taskEditingController,
            validator: (value) {
              if (formScreenValidator.validateValue(value) == false) {
                return taskErrorMessage;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
