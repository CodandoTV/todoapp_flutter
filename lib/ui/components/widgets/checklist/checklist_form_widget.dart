import 'package:flutter/material.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/components/widgets/form/form_field_widget.dart';

class ChecklistFormWidget extends StatelessWidget {
  final Key formKey;
  final TextEditingController checklistEditingController;
  final FormScreenValidator formScreenValidator;
  final String checklistLabel;
  final String checklistErrorMessage;

  const ChecklistFormWidget({
    super.key,
    required this.formKey,
    required this.checklistLabel,
    required this.checklistErrorMessage,
    required this.checklistEditingController,
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
              labelText: checklistLabel,
              controller: checklistEditingController,
              validator: (value) {
                if (formScreenValidator.validateValue(value) == false) {
                  return checklistErrorMessage;
                }
                return null;
              }),
        ],
      ),
    );
  }
}
