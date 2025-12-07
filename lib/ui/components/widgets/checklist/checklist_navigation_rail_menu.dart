import 'package:flutter/material.dart';

class ChecklistNavigationRailMenu extends StatelessWidget {
  final IconData newChecklistIcon;
  final String newChecklistLabel;
  final IconData newTaskIcon;
  final String newTaskLabel;
  final VoidCallback onNewChecklistPressed;
  final VoidCallback onNewTaskPressed;

  const ChecklistNavigationRailMenu({
    super.key,
    required this.newChecklistIcon,
    required this.newChecklistLabel,
    required this.newTaskIcon,
    required this.newTaskLabel,
    required this.onNewChecklistPressed,
    required this.onNewTaskPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: [
        NavigationRailDestination(
          icon: IconButton(
            icon: Icon(newChecklistIcon),
            onPressed: onNewChecklistPressed,
          ),
          label: Text(newChecklistLabel),
        ),
        NavigationRailDestination(
          icon: IconButton(
            icon: Icon(newTaskIcon),
            onPressed: onNewTaskPressed,
          ),
          label: Text(newTaskLabel),
        ),
      ],
      labelType: NavigationRailLabelType.all,
      selectedIndex: null,
    );
  }
}
