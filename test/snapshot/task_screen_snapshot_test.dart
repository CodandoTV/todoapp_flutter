import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';
import 'package:todoapp/ui/screens/task/task_screen_text_values.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'TaskScreen - Snapshot - Insert a new task',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TaskScreenScaffold(
          navigatorProvider: FakeNavigatorProvider(),
          onAddNewTask: (_) => {},
          taskScreenTextValues: TaskScreenTextValues(
            taskErrorMessage: 'Task name is required',
            taskLabel: 'Task',
          ),
          formScreenValidator: FormScreenValidator(),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TaskScreenScaffold),
        matchesGoldenFile(
          'goldens/task_screen_snapshot.png',
        ),
      );
    },
  );
}
