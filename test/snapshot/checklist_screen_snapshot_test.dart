import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen_text_values.dart';

import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'ChecklistScreen - Snapshot - Insert a new checklist',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: ChecklistScreenScaffold(
          checklistScreenTextValues: ChecklistScreenTextValues(
            screenTitle: 'Checklist',
            checklistLabel: 'Checklist',
            checklistErrorMessage: 'Checklist name is required',
          ),
          onAddNewChecklist: (_) => {},
          formScreenValidator: FormScreenValidator(),
          onPop: (_) => {},
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(ChecklistScreenScaffold),
        matchesGoldenFile(
          'goldens/checklist_screen_snapshot.png',
        ),
      );
    },
  );
}
