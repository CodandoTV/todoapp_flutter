import 'package:flutter/material.dart';
import 'package:todo_app/presentation/todo_app_navigator.dart';

import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'Tasks'),
      body: Center(
        child: IconButton(
          icon: const Icon(
            Icons.plus_one,
          ),
          onPressed: () {
            TodoAppNavigator.pushTaskScreen(context);
          },
        ),
      ),
    );
  }
}
