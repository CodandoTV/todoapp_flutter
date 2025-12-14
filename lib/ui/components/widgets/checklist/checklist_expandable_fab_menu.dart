import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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
        Column(
          children: [
            FloatingActionButton.small(
              onPressed: onNewTaskPressed,
              child: const Icon(Icons.add_task),
            ),
            const SizedBox(width: 10),
            Text(localizations.add_task),
          ],
        ),
        Column(
          children: [
            FloatingActionButton.small(
              onPressed: onNewChecklistPressed,
              child: const Icon(Icons.plus_one),
            ),
            const SizedBox(width: 10),
            Text(localizations.add_checklist),
          ],
        )
      ],
    );
  }
}
