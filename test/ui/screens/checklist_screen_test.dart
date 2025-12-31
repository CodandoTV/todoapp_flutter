import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/components/form_validator.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';

import '../../test_utils/fakes/fake_navigator_provider.dart';
import '../../test_utils/widgets_util.dart';

void main() {
  testWidgets(
    'ChecklistScreen - Insert a new checklist',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: ChecklistScreenScaffold(
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
