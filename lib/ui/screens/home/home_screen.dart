import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';
import 'package:todoapp/ui/widgets/tasks_list.dart';
import '../../widgets/custom_app_bar.dart';
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
          onDeleteTasks: viewModel.deleteSelectedTasks,
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
  final Function(TaskCell, bool) onCompleteTask;
  final Function onDeleteTasks;
  final Function onRemoveTask;

  const _HomeScaffold({
    required this.uiState,
    required this.updateTasks,
    required this.onCompleteTask,
    required this.onDeleteTasks,
    required this.onRemoveTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.tasks,
        showTrashIcon: uiState.showTrashIcon,
        onDelete: () => onDeleteTasks(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await context.push('/task');
          if (result == true) {
            updateTasks();
            if(context.mounted) {
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
      body: TasksList(
        taskUiModels: uiState.taskUiModels,
        onRemoveTask: onRemoveTask,
        onCompleteTask: onCompleteTask,
      ),
    );
  }
}
