import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/model/task.dart';
import 'package:todo_app/domain/model/task_type.dart';
import 'package:todo_app/domain/usecases/add_new_task_usecase.dart';
import 'package:todo_app/domain/usecases/get_categories_usecase.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';
import 'package:todo_app/presentation/widgets/task_category_dropdown.dart';

class TaskScreen extends StatefulWidget {
  final String? taskUuid;

  const TaskScreen({super.key, required this.taskUuid});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final AddNewTaskUseCase _addNewTaskUseCase =
      DependencyFactory.getAddNewTaskUseCase();

  final GetCategoriesUseCase _getCategoriesUseCase =
      DependencyFactory.getGetCategoriesUseCase();

  String? _currentCategory =
      DependencyFactory.getGetCategoriesUseCase().get().first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Task'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var category = TaskType.values.firstWhere(
              (task) => task.name == _currentCategory,
              orElse: () => TaskType.unknown
          );

          _addNewTaskUseCase.add(
            Task(
              title: _taskEditingController.text,
              desc: _descriptionEditingController.text,
              type: category,
              isCompleted: false,
            ),
          );

          Navigator.pop(context, true);
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
              initialValue: _getCategoriesUseCase.get().first,
              values: _getCategoriesUseCase.get(),
              onChanged: (String? value) {
                _currentCategory = value;
              },
            )
          ],
        ),
      ),
    );
  }
}
