import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';
import 'package:todoapp/ui/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/widgets/task_form_widget.dart';

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
      getIt.get(),
      checklistId,
    );

    return _TaskScreenScaffold(
          onAddNewTask: (title) => viewModel.addTask(
            title: title,
          ),
          formScreenValidator: getIt.get(),
        );
  }
}

class _TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();
  final Function(String) onAddNewTask;
  final FormScreenValidator formScreenValidator;
  final _formKey = GlobalKey<FormState>();

  _TaskScreenScaffold({
    required this.onAddNewTask,
    required this.formScreenValidator,
  });

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
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
            router.pop(true);
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
          taskEditingController: _taskEditingController,
          formScreenValidator: formScreenValidator,
        ),
      ),
    );
  }
}
