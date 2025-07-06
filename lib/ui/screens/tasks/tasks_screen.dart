import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/generated/app_localizations.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_viewmodel.dart';
import 'package:todoapp/ui/screens/todoapp_navigator.dart';
import 'package:todoapp/ui/widgets/task/tasks_list_widget.dart';
import '../../../data/model/task.dart';
import '../../widgets/confirmation_alert_dialog_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

class TasksScreen extends StatelessWidget {
  final Checklist checklist;

  const TasksScreen({
    super.key,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TasksViewModel(getIt.get(), checklist.id);
    viewModel.updateTasks();

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<TasksViewModel, TasksScreenState>(
        builder: (context, uiState) => _TasksScaffold(
          uiState: uiState,
          checklistId: checklist.id,
          checklistName: checklist.title,
          onCompleteTask: viewModel.onCompleteTask,
          onRemoveTask: viewModel.onRemoveTask,
          updateTasks: viewModel.updateTasks,
          onReorder: viewModel.reorder,
        ),
      ),
    );
  }
}

class _TasksScaffold extends StatelessWidget {
  final TasksScreenState uiState;
  final int? checklistId;
  final String checklistName;
  final Function updateTasks;
  final Function(Task, bool) onCompleteTask;
  final Function(Task) onRemoveTask;
  final Function(int oldIndex, int newIndex) onReorder;
  final TodoAppNavigator navigator = getIt.get();

  _TasksScaffold({
    required this.uiState,
    required this.checklistId,
    required this.checklistName,
    required this.updateTasks,
    required this.onCompleteTask,
    required this.onRemoveTask,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: checklistName,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await navigator.navigateToTaskScreen(
            context,
            checklistId,
          );
          if (result == true) {
            await updateTasks();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.task_added,
                  ),
                ),
              );
            }
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: TasksListWidget(
          tasks: uiState.tasks,
          onReorder: onReorder,
          onRemoveTask: (task) =>
              _showConfirmationDialogToRemoveTask(context, task),
          onCompleteTask: onCompleteTask,
        ),
      ),
    );
  }

  _showConfirmationDialogToRemoveTask(BuildContext context, Task task) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationAlertDialogWidget(
        title: appLocalizations.remove_task_dialog_title,
        description: appLocalizations.remove_task_dialog_desc,
        secondaryButtonText: appLocalizations.no,
        primaryButtonText: appLocalizations.yes,
        onSecondaryButtonPressed: () => {
          navigator.pop(context),
        },
        onPrimaryButtonPressed: () =>
            {navigator.pop(context), onRemoveTask(task)},
      ),
    );
  }
}
