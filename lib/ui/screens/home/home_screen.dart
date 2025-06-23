import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';
import 'package:todoapp/ui/widgets/tasks_list_widget.dart';
import '../../../data/model/task.dart';
import '../../widgets/confirmation_alert_dialog_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'home_screen_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel(getIt.get());
    viewModel.updateTasks();

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<HomeViewModel, HomeScreenState>(
        builder: (context, uiState) => _HomeScaffold(
          uiState: uiState,
          onCompleteTask: viewModel.onCompleteTask,
          onRemoveTask: viewModel.onRemoveTask,
          updateTasks: viewModel.updateTasks,
        ),
      ),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  final HomeScreenState uiState;
  final Function updateTasks;
  final Function(Task, bool) onCompleteTask;
  final Function(Task) onRemoveTask;

  const _HomeScaffold({
    required this.uiState,
    required this.updateTasks,
    required this.onCompleteTask,
    required this.onRemoveTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.tasks,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await context.push('/task');
          if (result == true) {
            updateTasks();
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
      body: TasksListWidget(
        tasks: uiState.tasks,
        onRemoveTask: (task) =>
            _showConfirmationDialogToRemoveTask(context, task),
        onCompleteTask: onCompleteTask,
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
          Navigator.pop(context),
        },
        onPrimaryButtonPressed: () =>
            {Navigator.pop(context), onRemoveTask(task)},
      ),
    );
  }
}
