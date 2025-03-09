import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/custom_app_bar.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Task'),
    );
  }
}
