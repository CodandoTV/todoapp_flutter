import 'package:flutter/cupertino.dart';
import 'package:todo_app/presentation/task/task_screen.dart';

class TodoAppNavigator {
  static pushTaskScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const TaskScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
