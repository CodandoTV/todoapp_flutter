import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';
import 'package:todoapp/ui/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/widgets/task_form_widget.dart';

import '../../../util/di/dependency_startup_handler.dart';
import '../../l10n/app_localizations.dart';

@RoutePage()
class TaskScreen extends StatelessWidget {
  final int? checklistId;

  const TaskScreen({
    super.key,
    required this.checklistId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(
      GetItStartupHandlerWrapper.getIt.get(),
      checklistId,
    );
    final router = AutoRouter.of(context);
    final taskErrorMessage = AppLocalizations.of(context)!.task_name_required;
    final taskLabel = AppLocalizations.of(context)!.task;

    return TaskScreenScaffold(
      taskErrorMessage: taskErrorMessage,
      taskLabel: taskLabel,
      onAddNewTask: (title) => viewModel.addTask(
        title: title,
      ),
      formScreenValidator: GetItStartupHandlerWrapper.getIt.get(),
      onPop: (result) => {router.pop(result)},
    );
  }
}

class TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();
  final Function(String) onAddNewTask;
  final FormScreenValidator formScreenValidator;
  final _formKey = GlobalKey<FormState>();
  final Function(bool) onPop;
  final String taskErrorMessage;
  final String taskLabel;

  TaskScreenScaffold({
    super.key,
    required this.taskErrorMessage,
    required this.taskLabel,
    required this.onAddNewTask,
    required this.formScreenValidator,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        title: 'Task',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          await onAddNewTask(
            _taskEditingController.text,
          );
          if (context.mounted) {
            onPop(true);
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TaskFormWidget(
          formKey: _formKey,
          taskLabel: taskLabel,
          taskErrorMessage: taskErrorMessage,
          taskEditingController: _taskEditingController,
          formScreenValidator: formScreenValidator,
        ),
      ),
    );
  }
}
