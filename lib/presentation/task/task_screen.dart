import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/data/model/task.dart';
import 'package:todo_app/data/model/task_type.dart';
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

  late TodoRepository _repository;

  late String? _currentCategory;

  @override
  void initState() {
    super.initState();

    _repository = context.read();
    _currentCategory = _repository.getCategories().first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Task', showTrashIcon: false,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var category = TaskType.values.firstWhere(
              (task) => task.name == _currentCategory,
              orElse: () => TaskType.unknown
          );

          _repository.add(
            Task(
              title: _taskEditingController.text,
              desc: _descriptionEditingController.text,
              type: category,
              isCompleted: false,
            ),
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
              initialValue: _repository.getCategories().first,
              values: _repository.getCategories(),
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
