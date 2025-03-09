import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatelessWidget {
  final String? taskUuid;

  const TaskScreen({super.key, required this.taskUuid});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Task'),
    );
  }
}
