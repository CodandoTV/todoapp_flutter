import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';

import '../fakes/fake_navigator_provider.dart';
import '../fakes/fake_text_values.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TaskScreen - Insert a new task',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TaskScreenScaffold(
          navigatorProvider: FakeNavigatorProvider(),
          addTaskOrUpdate: (p0) {
            return Future.value(false);
          },
          floatingActionIcon: Icons.plus_one,
          taskScreenTextValues: FakeTextValues.taskScreenTextValues,
          formScreenValidator: FormScreenValidator(),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      expect(
        find.byType(FloatingActionButton),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'TaskScreen - Show taskTitle if the user is updating an existing task',
    (tester) async {
      const existingTaskTitle = 'Buy dog food';

      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TaskScreenScaffold(
          taskTitle: existingTaskTitle,
          navigatorProvider: FakeNavigatorProvider(),
          addTaskOrUpdate: (p0) {
            return Future.value(false);
          },
          floatingActionIcon: Icons.save,
          taskScreenTextValues: FakeTextValues.taskScreenTextValues,
          formScreenValidator: FormScreenValidator(),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      expect(
        find.textContaining(existingTaskTitle),
        findsOneWidget,
      );
    },
  );
}
