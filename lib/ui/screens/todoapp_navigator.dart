import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';

import '../../data/model/checklist.dart';

@injectable
class TodoAppNavigator {
  Future<bool> navigateToTaskScreen(
      BuildContext context, int? checklistId) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskScreen(
          checklistId: checklistId,
        ),
      ),
    );
  }

  Future<bool> navigateToChecklistScreen(BuildContext context) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChecklistScreen(),
      ),
    );
  }

  navigateToTasksScreen(BuildContext context, Checklist checklist) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TasksScreen(checklist: checklist),
      ),
    );
  }

  pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  popWithResult(BuildContext context, bool result) {
    Navigator.of(context).pop(result);
  }
}
