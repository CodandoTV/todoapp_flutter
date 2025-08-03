import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen_state.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen_text_values.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'ChecklistsScreen - Snapshot - Empty state',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: ChecklistsScaffold(
          uiState: const ChecklistsScreenState(
            checklists: [],
            isLoading: false,
          ),
          checklistsScreenTextValues: const ChecklistsScreenTextValues(
            screenTitle: 'checklists',
            checklistAdded: 'A new checklist has been added',
            removeChecklistDialogTitle: 'Are you sure you want to remove it?',
            removeChecklistDialogDesc: 'Remove this checklist',
            yes: 'yes',
            no: 'no',
            emptyChecklistMessage: 'You have no checklists',
          ),
          onRemoveChecklist: (_) => {},
          navigatorProvider: FakeNavigatorProvider(),
          updateChecklists: () => {},
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(ChecklistsScaffold),
        matchesGoldenFile(
          'goldens/checklists_screen_empty_state_snapshot.png',
        ),
      );
    },
  );
}
