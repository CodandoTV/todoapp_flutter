import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/model/task.dart';
import 'package:todo_app/domain/model/task_type.dart';
import 'package:todo_app/domain/usecases/add_new_task_usecase.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';

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

  final AddNewTaskUseCase addNewTaskUseCase =
      DependencyFactory.getAddNewTaskUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Task'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTaskUseCase.add(
            Task(
              title: _taskEditingController.text,
              desc: _descriptionEditingController.text,
              type: TaskType.chores,
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
            DropdownButtonFormField<String>(
              value: "Pets",
              decoration: const InputDecoration(
                labelText: "Type",
                border: OutlineInputBorder(),
              ),
              items: ["Pets", "Supermarket", "Chores"]
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
