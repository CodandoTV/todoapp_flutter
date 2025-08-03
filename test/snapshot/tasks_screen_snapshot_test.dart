import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_text_values.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TasksScreen - Snapshot - Empty state',
    (tester) async {
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
}
