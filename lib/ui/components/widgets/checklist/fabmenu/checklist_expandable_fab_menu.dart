import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:todoapp/ui/components/widgets/checklist/fabmenu/checklist_fabmenu_item.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class ChecklistExpandableFabMenu extends StatefulWidget {
  final Function() onNewChecklistPressed;
  final Function() onNewTaskPressed;
  final Function() onSharePressed;
  final Function() onSortPressed;

  const ChecklistExpandableFabMenu({
    super.key,
    required this.onNewChecklistPressed,
    required this.onNewTaskPressed,
    required this.onSharePressed,
    required this.onSortPressed,
  });

  @override
  State<ChecklistExpandableFabMenu> createState() =>
      _ChecklistExpandableFabMenuState();
}

class _ChecklistExpandableFabMenuState
    extends State<ChecklistExpandableFabMenu> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.side,
      overlayStyle: const ExpandableFabOverlayStyle(
        blur: 1.0,
      ),
      children: [
        ChecklistFabMenuItem(
          heroTag: 'new_task',
          onPressed: () => {
            _key.currentState?.close(),
            widget.onNewTaskPressed(),
          },
          label: localizations.task,
          icon: Icons.add_task,
        ),
        ChecklistFabMenuItem(
          heroTag: 'new_checklist',
          onPressed: () => {
            _key.currentState?.close(),
            widget.onNewChecklistPressed(),
          },
          label: localizations.checklist,
          icon: Icons.plus_one,
        ),
        ChecklistFabMenuItem(
          heroTag: 'share',
          onPressed: () => {
            _key.currentState?.close(),
            widget.onSharePressed(),
          },
          label: localizations.share,
          icon: Icons.share,
        ),
        ChecklistFabMenuItem(
          heroTag: 'sort',
          onPressed: () => {
            _key.currentState?.close(),
            widget.onSortPressed(),
          },
          label: localizations.sort,
          icon: Icons.sort,
        )
      ],
    );
  }
}
