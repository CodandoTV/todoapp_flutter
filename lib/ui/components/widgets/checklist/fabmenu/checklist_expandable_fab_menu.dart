import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:todoapp/ui/components/widgets/checklist/fabmenu/checklist_fabmenu_item.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class ChecklistExpandableFabMenu extends StatelessWidget {
  final Function() onNewChecklistPressed;
  final Function() onNewTaskPressed;

  const ChecklistExpandableFabMenu({
    super.key,
    required this.onNewChecklistPressed,
    required this.onNewTaskPressed,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return ExpandableFab(
      type: ExpandableFabType.side,
      children: [
        ChecklistFabMenuItem(
          heroTag: 'new_task',
          onPressed: onNewTaskPressed,
          label: localizations.task,
          icon: Icons.add_task,
        ),
        ChecklistFabMenuItem(
          heroTag: 'new_checklist',
          onPressed: onNewChecklistPressed,
          label: localizations.checklist,
          icon: Icons.plus_one,
        ),
      ],
    );
  }
}
