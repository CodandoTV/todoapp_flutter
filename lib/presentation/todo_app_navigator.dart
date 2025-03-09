import 'package:flutter/cupertino.dart';
import 'package:todo_app/presentation/task/task_screen.dart';

class TodoAppNavigator {
  static pushTaskScreen({required BuildContext context, String? taskUuid}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TaskScreen(
          taskUuid: taskUuid,
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
