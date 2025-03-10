import 'package:flutter/cupertino.dart';
import 'package:todo_app/presentation/task/task_screen.dart';

class TodoAppRouteFactory {
  static PageRouteBuilder taskScreenRouteFactory(String? taskUuid){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TaskScreen(
        taskUuid: taskUuid,
      ),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
