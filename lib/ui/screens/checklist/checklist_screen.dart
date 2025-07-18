import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/checklist/checklist_viewmodel.dart';
import 'package:todoapp/ui/widgets/checklist_form_widget.dart';
import 'package:todoapp/ui/widgets/custom_app_bar_widget.dart';

import '../../components/form_validator.dart';

@RoutePage()
class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ChecklistViewModel(getIt.get());

    return _ChecklistScreenScaffold(
      formScreenValidator: getIt.get(),
      onAddNewChecklist: (title) => viewModel.addChecklist(
        title: title,
      ),
    );
  }
}

class _ChecklistScreenScaffold extends StatelessWidget {
  final TextEditingController _checklistEditingController =
      TextEditingController();
  final Function(String) onAddNewChecklist;
  final _formKey = GlobalKey<FormState>();
  final FormScreenValidator formScreenValidator;

  _ChecklistScreenScaffold({
    required this.onAddNewChecklist,
    required this.formScreenValidator,
  });

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.checklist,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          await onAddNewChecklist(
            _checklistEditingController.text,
          );
          if (context.mounted) {
            router.pop(true);
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ChecklistFormWidget(
          formKey: _formKey,
          formScreenValidator: formScreenValidator,
          checklistEditingController: _checklistEditingController,
        ),
      ),
    );
  }
}
