import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_form_widget.dart';
import 'package:todoapp/ui/components/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/checklist/checklist_viewmodel.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';
import 'package:todoapp/util/navigation_provider.dart';

@RoutePage()
class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ChecklistViewModel(
      GetItStartupHandlerWrapper.getIt.get(),
    );

    return ChecklistScreenScaffold(
      formScreenValidator: GetItStartupHandlerWrapper.getIt.get(),
      onAddNewChecklist: (title) => viewModel.addChecklist(
        title: title,
      ),
      navigatorProvider: GetItStartupHandlerWrapper.getIt.get(),
    );
  }
}

class ChecklistScreenScaffold extends StatelessWidget {
  final TextEditingController _checklistEditingController =
      TextEditingController();
  final Function(String) onAddNewChecklist;
  final _formKey = GlobalKey<FormState>();
  final FormScreenValidator formScreenValidator;
  final NavigatorProvider navigatorProvider;

  ChecklistScreenScaffold({
    super.key,
    required this.onAddNewChecklist,
    required this.formScreenValidator,
    required this.navigatorProvider,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: localizations.checklist,
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
            navigatorProvider.onPop(context, true);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ChecklistFormWidget(
          formKey: _formKey,
          checklistLabel: localizations.checklist_name,
          checklistErrorMessage: localizations.checklist_name_required,
          formScreenValidator: formScreenValidator,
          checklistEditingController: _checklistEditingController,
        ),
      ),
    );
  }
}
