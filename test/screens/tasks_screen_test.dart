import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_text_values.dart';
import 'package:todoapp/ui/widgets/progress_widget.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TasksScreen - Empty state',
    (tester) async {
      const emptyMessage = 'No Tasks available';

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
          checklistName: 'Pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'Task added.',
            removeTaskDialogTitle: 'Remove task',
            removeTaskDialogDesc: 'Are you sure?',
            yes: 'yes',
            no: 'no',
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
    'TasksScreen - Some tasks with progress 50%',
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
          onSort: () {},
          checklistId: 1,
          checklistName: 'Pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'Task Added',
            removeTaskDialogTitle: 'Remove Task',
            removeTaskDialogDesc: 'Are you sure?',
            yes: 'yes',
            no: 'no',
            emptyTasksMessage: 'No tasks available',
          ),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      ProgressWidget? progressWidget = find
          .byType(ProgressWidget)
          .evaluate()
          .first
          .widget as ProgressWidget?;

      expect(progressWidget!.getProgress(), 0.5);
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
          onSort: () {},
          checklistId: 1,
          checklistName: 'pets',
          tasksScreenTextValues: const TasksScreenTextValues(
            taskAdded: 'Task added.',
            removeTaskDialogTitle: 'Remove task',
            removeTaskDialogDesc: 'Are you sure?',
            yes: 'yes',
            no: 'no',
            emptyTasksMessage: 'No tasks here',
          ),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      ProgressWidget? progressWidget = find
          .byType(ProgressWidget)
          .evaluate()
          .first
          .widget as ProgressWidget?;

      expect(progressWidget!.getProgress(), 1.0);
    },
  );
}
