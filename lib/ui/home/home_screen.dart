import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/home/home_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/task/task_cell_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel(context.read());
    viewModel.updateTasks();
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => _HomeScaffold(viewModel),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  final HomeViewModel viewModel;

  const _HomeScaffold(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Tasks',
        showTrashIcon: viewModel.uiState.showTrashIcon,
        onDelete: viewModel.deleteSelectedTasks,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await context.push('/task');
          if (result == true) {
            viewModel.updateTasks();
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: ListView.builder(
        itemCount: viewModel.uiState.taskUiModels.length,
        itemBuilder: (context, index) {
          var taskCell = viewModel.uiState.taskUiModels[index];
          return TaskCellWidget(
            onLongPress: () => {viewModel.onRemoveTask(taskCell.task)},
            onCheckChanged: (value) => {
              viewModel.onCompleteTask(
                taskCell,
                value ?? false,
              ),
            },
            cell: taskCell,
          );
        },
      ),
    );
  }
}
