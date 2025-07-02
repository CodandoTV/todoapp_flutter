import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/checklist/checklist_viewmodel.dart';
import 'package:todoapp/ui/widgets/checklist_form_widget.dart';
import 'package:todoapp/ui/widgets/custom_app_bar_widget.dart';

class ChecklistScreen extends StatelessWidget {
  final String? checkListUuid;

  const ChecklistScreen({super.key, required this.checkListUuid});

  @override
  Widget build(BuildContext context) {
    final viewModel = ChecklistViewModel(getIt.get());

    return _ChecklistScreenScaffold(
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

  _ChecklistScreenScaffold({
    required this.onAddNewChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Checklist',
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
            context.pop(true);
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChecklistFormWidget(
          formKey: _formKey,
          checklistEditingController: _checklistEditingController,
        ),
      ),
    );
  }
}
