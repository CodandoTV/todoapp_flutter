import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/task/task_screen_state.dart';
import 'package:todoapp/ui/task/task_viewmodel.dart';
import 'package:todoapp/ui/widgets/custom_app_bar.dart';
import 'package:todoapp/ui/widgets/task_category_dropdown.dart';

class TaskScreen extends StatelessWidget {
  final String? taskUuid;

  const TaskScreen({super.key, required this.taskUuid});

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(getIt.get());
    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<TaskViewModel, TaskScreenState>(
        builder: (context, uiState) =>
            _TaskScreenScaffold(
              uiState: uiState,
              onAddNewTask: (title, description) =>
                  viewModel.addTask(
                    title: title,
                    description: description,
                  ),
              onCategoryChanged: viewModel.onCategoryChanged,
            ),
      ),
    );
  }
}

class _TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
  TextEditingController();

  final TaskScreenState uiState;

  final Function(String, String) onAddNewTask;
  final Function(String?) onCategoryChanged;

  _TaskScreenScaffold({
    required this.uiState,
    required this.onAddNewTask,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Task',
        showTrashIcon: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await onAddNewTask(
            _taskEditingController.text,
            _descriptionEditingController.text,
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
        child: Column(
          children: [
            TextField(
              controller: _taskEditingController,
              decoration: const InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionEditingController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TaskCategoryDropdown(
              initialValue: uiState.selectedCategory,
              values: uiState.categoryNames,
              onChanged: onCategoryChanged,
            )
          ],
        ),
      ),
    );
  }
}
