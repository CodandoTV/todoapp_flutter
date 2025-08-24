import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/widgets/progress_widget.dart';

import '../fakes/fake_navigator_provider.dart';
import '../fakes/fake_text_values.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TasksScreen - Empty state message should appear if there is no task',
    (tester) async {
      const emptyMessage = 'No Tasks available';

      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TasksScaffold(
          navigatorProvider: FakeNavigatorProvider(),
          uiState: const TasksScreenState(
            tasks: [],
            isLoading: false,
            progress: 0,
            showShareIcon: false,
          ),
          updateTasks: () => {},
          onShare: () => {},
          onCompleteTask: (_, __) => {},
          onRemoveTask: (_) => {},
          onReorder: (_, __) => {},
          checklistId: 1,
          checklistName: 'Pets',
          tasksScreenTextValues: FakeTextValues.tasksScreenTextValues.copyWith(
            emptyTasksMessage: emptyMessage,
          ),
          onSort: () {},
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      expect(find.text(emptyMessage), findsOneWidget);
    },
  );

  testWidgets(
    'TasksScreen - Progress bar should be blue if it is not 100% completed',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TasksScaffold(
          navigatorProvider: FakeNavigatorProvider(),
          uiState: const TasksScreenState(
            tasks: [
              Task(id: 1, title: 'task1', isCompleted: false),
              Task(id: 2, title: 'task2', isCompleted: true),
              Task(id: 3, title: 'task3', isCompleted: false),
              Task(id: 4, title: 'task4', isCompleted: true),
            ],
            isLoading: false,
            progress: 0.5,
            showShareIcon: true,
          ),
          updateTasks: () => {},
          onShare: () => {},
          onCompleteTask: (_, __) => {},
          onRemoveTask: (_) => {},
          onReorder: (_, __) => {},
          onSort: () {},
          checklistId: 1,
          checklistName: 'Pets',
          tasksScreenTextValues: FakeTextValues.tasksScreenTextValues,
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      ProgressWidget? progressWidget = find
          .byType(ProgressWidget)
          .evaluate()
          .first
          .widget as ProgressWidget?;

      expect(progressWidget!.baseColor(), Colors.blueAccent);
    },
  );

  testWidgets(
    'TasksScreen - Progress bar should be green if it is 100% completed',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TasksScaffold(
          navigatorProvider: FakeNavigatorProvider(),
          uiState: const TasksScreenState(
            tasks: [
              Task(id: 2, title: 'task2', isCompleted: true),
              Task(id: 4, title: 'task4', isCompleted: true),
            ],
            isLoading: false,
            progress: 1,
            showShareIcon: false,
          ),
          updateTasks: () => {},
          onShare: () => {},
          onCompleteTask: (_, __) => {},
          onRemoveTask: (_) => {},
          onReorder: (_, __) => {},
          onSort: () {},
          checklistId: 1,
          checklistName: 'pets',
          tasksScreenTextValues: FakeTextValues.tasksScreenTextValues,
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      ProgressWidget? progressWidget = find
          .byType(ProgressWidget)
          .evaluate()
          .first
          .widget as ProgressWidget?;

      expect(progressWidget!.baseColor(), Colors.green);
    },
  );
}
