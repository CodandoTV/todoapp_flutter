import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/components/remove_task_dialog_builder.dart';
import 'package:todoapp/ui/components/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/components/widgets/progress_widget.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_list_widget.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_screen_state.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_viewmodel.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_callbacks.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';
import 'package:todoapp/util/navigation_provider.dart';

const shareOptionKey = 'shareOption';

@RoutePage()
class TasksScreen extends StatelessWidget {
  final Checklist checklist;

  const TasksScreen({
    super.key,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    final getIt = GetItStartupHandlerWrapper.getIt;
    final viewModel = TasksViewModel(
      repository: getIt.get(),
      shareMessageHandler: getIt.get(),
      shouldShowShareButtonUseCase: getIt.get(),
      formatTaskListMessageUseCase: getIt.get(),
      tasksSorterUseCase: getIt.get(),
      tasksComparatorUseCase: getIt.get(),
      progressCounterUseCase: getIt.get(),
    );
    viewModel.updateTasks(checklist.id);

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<TasksViewModel, TasksScreenState>(
        builder: (context, uiState) => TasksScaffold(
          navigatorProvider: getIt.get(),
          uiState: uiState,
          checklistId: checklist.id,
          checklistName: checklist.title,
          callbacks: TasksScreenCallbacks(
            onCompleteTask: viewModel.onCompleteTask,
            onRemoveTask: viewModel.onRemoveTask,
            updateTasks: viewModel.updateTasks,
            onReorder: viewModel.reorder,
            onSort: () => {viewModel.onSort()},
            onShare: () => {
              viewModel.shareTasks(checklistName: checklist.title),
            },
          ),
        ),
      ),
    );
  }
}

class TasksScaffold extends StatelessWidget {
  final TasksScreenState uiState;
  final int? checklistId;
  final String checklistName;
  final TasksScreenCallbacks callbacks;
  final NavigatorProvider navigatorProvider;

  const TasksScaffold({
    super.key,
    required this.uiState,
    required this.checklistId,
    required this.checklistName,
    required this.navigatorProvider,
    required this.callbacks,
  });

  Widget _buildFloatingActionButton(Function() onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.plus_one),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: checklistName,
        actions: _buildTopBarActions(
          context: context,
          sortedMessage: localizations.sort_message,
          onShare: callbacks.onShare,
          showShareButton: uiState.showShareIcon,
          onSort: callbacks.onSort,
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(
        () async {
          await _navigateToTaskScreen(
            context,
            checklistId: checklistId,
          );
        },
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
              emptyTasksMessage: localizations.empty_tasks,
              onReorder: callbacks.onReorder,
              onRemoveTask: (task) =>
                  _showConfirmationDialogToRemoveTask(context, task),
              onCompleteTask: callbacks.onCompleteTask,
              onTap: (task) => {
                _navigateToTaskScreen(
                  context,
                  checklistId: checklistId,
                  task: task,
                )
              },
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

  void _showConfirmationDialogToRemoveTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) => RemoveTaskDialogBuilder.build(
        context: context,
        onSecondaryButtonPressed: () => {
          navigatorProvider.onPop(context, null),
        },
        onPrimaryButtonPressed: () => {
          navigatorProvider.onPop(context, null),
          callbacks.onRemoveTask(task),
        },
      ),
    );
  }

  List<Widget> _buildTopBarActions({
    required bool showShareButton,
    required String sortedMessage,
    required VoidCallback onShare,
    required VoidCallback onSort,
    required BuildContext context,
  }) {
    List<Widget> menuActions = [];

    if (showShareButton) {
      menuActions.add(
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.share),
          key: const ValueKey(shareOptionKey),
        ),
      );
    }

    menuActions.add(
      IconButton(
        onPressed: () => {
          onSort(),
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                sortedMessage,
              ),
            ),
          ),
        },
        icon: const Icon(Icons.sort),
      ),
    );

    return menuActions;
  }

  Future<void> _navigateToTaskScreen(
    BuildContext context, {
    required int? checklistId,
    Task? task,
  }) async {
    final localizations = AppLocalizations.of(context)!;

    bool? result = await navigatorProvider.push(
      context,
      TaskRoute(
        checklistId: checklistId,
        task: task,
      ),
    );
    if (result == true) {
      await callbacks.updateTasks(checklistId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              localizations.tasks_refresh,
            ),
          ),
        );
      }
    }
  }
}
