import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/task/task_bloc.dart';
import 'package:todo_app/ui/task/task_screen_state.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/task_category_dropdown.dart';

class TaskScreen extends StatelessWidget {
  final String? taskUuid;

  const TaskScreen({super.key, required this.taskUuid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext cubitContext) {
        return TaskScreenBloc(
          cubitContext.read(),
        );
      },
      child: _TaskScreenScaffold(),
    );
  }
}

class _TaskScreenScaffold extends StatelessWidget {
  final TextEditingController _taskEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskScreenBloc, TaskScreenState>(
        builder: (cubitContext, state) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'Task',
              showTrashIcon: false,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await cubitContext.read<TaskScreenBloc>().addTask(
                  title: _taskEditingController.text,
                  description: _descriptionEditingController.text,
                );
                context.pop(true);
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
                      labelText: "Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _descriptionEditingController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TaskCategoryDropdown(
                    initialValue: state.selectedCategory,
                    values: state.categoryNames,
                    onChanged: cubitContext.read<TaskScreenBloc>().onCategoryChanged,
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
