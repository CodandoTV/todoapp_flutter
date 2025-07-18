import 'package:flutter/material.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/l10n//app_localizations.dart';

class ChecklistFormWidget extends StatelessWidget {
  final Key formKey;
  final TextEditingController checklistEditingController;
  final FormScreenValidator formScreenValidator;

  const ChecklistFormWidget({
    super.key,
    required this.formKey,
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
          TextFormField(
            autofocus: true,
            controller: checklistEditingController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.checklist_name,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (formScreenValidator.validateValue(value) == false) {
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
