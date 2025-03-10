import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatelessWidget {
  final String? taskUuid;

  const TaskScreen({super.key, required this.taskUuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Task'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
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
