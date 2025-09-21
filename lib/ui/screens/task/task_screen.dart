import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/components/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/components/widgets/task_form_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/task/task_screen_text_values.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';
import 'package:todoapp/util/di/dependency_startup_handler.dart';
import 'package:todoapp/util/navigation_provider.dart';

@RoutePage()
class TaskScreen extends StatelessWidget {
  final int? checklistId;
  final Task? task;

  const TaskScreen({
    super.key,
    required this.checklistId,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(
      GetItStartupHandlerWrapper.getIt.get(),
      checklistId: checklistId,
      task: task,
    );
    final NavigatorProvider navigatorProvider =
        GetItStartupHandlerWrapper.getIt.get();

    final taskScreenTextValues = TaskScreenTextValues(
      taskErrorMessage: AppLocalizations.of(context)!.task_name_required,
      taskLabel: AppLocalizations.of(context)!.task,
    );

    return TaskScreenScaffold(
      taskTitle: task?.title,
      taskScreenTextValues: taskScreenTextValues,
      addTaskOrUpdate: (title) => viewModel.addTaskOrUpdate(
        title: title,
      ),
      floatingActionIcon: viewModel.getFloatingActionButtonIcon(),
      formScreenValidator: GetItStartupHandlerWrapper.getIt.get(),
      navigatorProvider: navigatorProvider,
    );
  }
}

class TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();
  final Future<bool> Function(String) addTaskOrUpdate;
  final FormScreenValidator formScreenValidator;
  final _formKey = GlobalKey<FormState>();
  final NavigatorProvider navigatorProvider;
  final TaskScreenTextValues taskScreenTextValues;
  final IconData floatingActionIcon;

  TaskScreenScaffold({
    super.key,
    String? taskTitle,
    required this.floatingActionIcon,
    required this.taskScreenTextValues,
    required this.addTaskOrUpdate,
    required this.formScreenValidator,
    required this.navigatorProvider,
  }) {
    _taskEditingController.text = taskTitle ?? '';
  }

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

          final result = await addTaskOrUpdate(
            _taskEditingController.text,
          );
          if (context.mounted) {
            navigatorProvider.onPop(context, result);
          }
        },
        child: Icon(floatingActionIcon),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TaskFormWidget(
          formKey: _formKey,
          taskLabel: taskScreenTextValues.taskLabel,
          taskErrorMessage: taskScreenTextValues.taskErrorMessage,
          taskEditingController: _taskEditingController,
          formScreenValidator: formScreenValidator,
        ),
      ),
    );
  }
}
