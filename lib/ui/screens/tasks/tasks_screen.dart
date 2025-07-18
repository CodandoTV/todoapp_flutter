import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_viewmodel.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/ui/widgets/progress_widget.dart';
import 'package:todoapp/ui/widgets/task/tasks_list_widget.dart';
import '../../../data/model/task.dart';
import '../../widgets/confirmation_alert_dialog_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

@RoutePage()
class TasksScreen extends StatelessWidget {
  final Checklist checklist;

  const TasksScreen({
    super.key,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TasksViewModel(
      formatTaskListUseCase: getIt.get(),
      repository: getIt.get(),
      shareMessageHandler: getIt.get(),
      checklistId: checklist.id,
      calculateTaskProgressUseCase: getIt.get(),
      shouldShowShareUseCase: getIt.get(),
    );
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
          onShare: () => {
            viewModel.shareTasks(checklistName: checklist.title),
          },
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
  final Function() onShare;

  const _TasksScaffold({
    required this.uiState,
    required this.checklistId,
    required this.checklistName,
    required this.updateTasks,
    required this.onCompleteTask,
    required this.onRemoveTask,
    required this.onReorder,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: checklistName,
        actions: _buildTopBarActions(
          showShareButton: uiState.showShareIcon,
          onShare: onShare,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await router.push(
            TaskRoute(
              checklistId: checklistId,
            ),
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
      body: Stack(
        children: [
          Padding(
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
          Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: ProgressWidget(
              progress: uiState.progress,
            ),
          ),
        ],
      ),
    );
  }

  _showConfirmationDialogToRemoveTask(BuildContext context, Task task) {
    final appLocalizations = AppLocalizations.of(context)!;
    final router = AutoRouter.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationAlertDialogWidget(
        title: appLocalizations.remove_task_dialog_title,
        description: appLocalizations.remove_task_dialog_desc,
        secondaryButtonText: appLocalizations.no,
        primaryButtonText: appLocalizations.yes,
        onSecondaryButtonPressed: () => {
          router.pop(),
        },
        onPrimaryButtonPressed: () =>
            {router.pop(), onRemoveTask(task)},
      ),
    );
  }

  List<Widget>? _buildTopBarActions({
    required bool showShareButton,
    required VoidCallback onShare,
  }) {
    if (showShareButton) {
      return [
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.share),
        ),
      ];
    } else {
      return null;
    }
  }
}
