import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/widgets/task/task_cell_widget.dart';

import '../widgets_util.dart';

void main() {
  testWidgets(
    'TaskCellWidget - Snapshot - NotCompleted',
    (tester) async {
      const taskName = 'Task A';

      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TaskCellWidget(
          task: const Task(
            id: null,
            title: taskName,
            isCompleted: false,
          ),
          onCheckChanged: (_) => {},
          onRemoveTask: (_) => {},
        ),
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TaskCellWidget),
        matchesGoldenFile(
            'goldens/task_cell_widget_not_completed_snapshot.png'),
      );
    },
  );

  testWidgets(
    'TaskCellWidget - Snapshot - NotCompleted',
    (tester) async {
      const taskName = 'Task A';

      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: TaskCellWidget(
          task: const Task(
            id: null,
            title: taskName,
            isCompleted: true,
          ),
          onCheckChanged: (_) => {},
          onRemoveTask: (_) => {},
        ),
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TaskCellWidget),
        matchesGoldenFile('goldens/task_cell_widget_completed_snapshot.png'),
      );
    },
  );
}
