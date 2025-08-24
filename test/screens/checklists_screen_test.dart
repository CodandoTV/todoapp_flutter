import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen_state.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen_text_values.dart';
import 'package:todoapp/ui/widgets/checklist/checklists_list_widget.dart';

import '../fakes/fake_navigator_provider.dart';
import '../utils/widgets_util.dart';

void main() {
  testWidgets(
    'ChecklistsScreen - Empty message should appear if we have no checklists',
    (tester) async {
      const emptyChecklistMessage = 'You have no checklists';

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
            emptyChecklistMessage: emptyChecklistMessage,
          ),
          onRemoveChecklist: (_) => {},
          navigatorProvider: FakeNavigatorProvider(),
          updateChecklists: () => {},
        ),
        tester: tester,
      );

      await tester.pumpWidget(widget);

      find.text(emptyChecklistMessage);

      expect(find.text(emptyChecklistMessage), findsOneWidget);
    },
  );

  testWidgets(
    'ChecklistsScreen - Checklist widget should appear if we have checklists',
    (tester) async {
      final widget = WidgetsUtil.buildMaterialAppWidgetTest(
        child: ChecklistsScaffold(
          uiState: const ChecklistsScreenState(
            checklists: [
              Checklist(id: null, title: 'pets'),
              Checklist(id: null, title: 'supermarket'),
              Checklist(id: null, title: 'drugstore'),
              Checklist(id: null, title: 'street market'),
            ],
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

      expect(find.byType(ChecklistsListWidget), findsOneWidget);
    },
  );
}
