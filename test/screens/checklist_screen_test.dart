import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen_text_values.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'ChecklistScreen - Insert a new checklist',
    (tester) async {
      final widget = await WidgetsUtil.buildMaterialAppWidgetTest(
        child: ChecklistScreenScaffold(
          checklistScreenTextValues: ChecklistScreenTextValues(
            screenTitle: 'Checklist',
            checklistLabel: 'Checklist',
            checklistErrorMessage: 'Checklist name is required',
          ),
          onAddNewChecklist: (_) => {},
          formScreenValidator: FormScreenValidator(),
          navigatorProvider: FakeNavigatorProvider(),
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      final floatActionButtonFinder = find.byType(FloatingActionButton);
      expect(floatActionButtonFinder, findsOneWidget);
    },
  );
}
