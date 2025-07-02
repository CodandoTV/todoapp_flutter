import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/task/task_screen_state.dart';
import 'package:todoapp/ui/screens/task/task_screen_validator.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';
import 'package:todoapp/ui/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/widgets/task_form_widget.dart';

class TaskScreen extends StatelessWidget {
  final int? checklistId;

  const TaskScreen({
    super.key,
    required this.checklistId,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(
      getIt.get(),
      checklistId,
    );

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<TaskViewModel, TaskScreenState>(
        builder: (context, uiState) => _TaskScreenScaffold(
          uiState: uiState,
          onAddNewTask: (title) => viewModel.addTask(
            title: title,
          ),
          taskScreenValidator: getIt.get(),
        ),
      ),
    );
  }
}

class _TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();

  final TaskScreenState uiState;

  final Function(String) onAddNewTask;

  final TaskScreenValidator taskScreenValidator;

  final _formKey = GlobalKey<FormState>();

  _TaskScreenScaffold({
    required this.uiState,
    required this.onAddNewTask,
    required this.taskScreenValidator,
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
            context.pop(true);
          }
        },
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskFormWidget(
          formKey: _formKey,
          taskEditingController: _taskEditingController,
          taskScreenValidator: taskScreenValidator,
          categoryNames: uiState.categoryNames,
        ),
      ),
    );
  }
}
