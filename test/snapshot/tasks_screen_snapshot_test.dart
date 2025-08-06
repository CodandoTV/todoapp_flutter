import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_text_values.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TasksScreen - Snapshot - Empty state',
    (tester) async {
      final widget = await WidgetsUtil.buildMaterialAppWidgetTest(
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
          checklistName: 'pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'taskAdded',
            removeTaskDialogTitle: 'removeTaskDialogTitle',
            removeTaskDialogDesc: 'removeTaskDialogDesc',
            yes: 'yes',
            no: 'no',
            emptyTasksMessage: 'emptyTasksMessage',
          ),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TasksScaffold),
        matchesGoldenFile(
          'goldens/tasks_screen_empty_state_snapshot.png',
        ),
      );
    },
  );

  testWidgets(
    'TasksScreen - Snapshot - Some tasks with progress 50%',
        (tester) async {
      final widget = await WidgetsUtil.buildMaterialAppWidgetTest(
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
          checklistId: 1,
          checklistName: 'pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'taskAdded',
            removeTaskDialogTitle: 'removeTaskDialogTitle',
            removeTaskDialogDesc: 'removeTaskDialogDesc',
            yes: 'yes',
            no: 'no',
            emptyTasksMessage: 'emptyTasksMessage',
          ),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TasksScaffold),
        matchesGoldenFile(
          'goldens/tasks_screen_fifty_percent_state_snapshot.png',
        ),
      );
    },
  );

  testWidgets(
    'TasksScreen - Snapshot - Some tasks with progress 100%',
        (tester) async {
      final widget = await WidgetsUtil.buildMaterialAppWidgetTest(
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
          checklistId: 1,
          checklistName: 'pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'taskAdded',
            removeTaskDialogTitle: 'removeTaskDialogTitle',
            removeTaskDialogDesc: 'removeTaskDialogDesc',
            yes: 'yes',
            no: 'no',
            emptyTasksMessage: 'emptyTasksMessage',
          ),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TasksScaffold),
        matchesGoldenFile(
          'goldens/tasks_screen_one_hundred_percent_state_snapshot.png',
        ),
      );
    },
  );
}
