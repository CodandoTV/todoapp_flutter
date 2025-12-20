import 'package:flutter/material.dart';

class ChecklistFabMenuItem extends StatelessWidget {
  final String heroTag;
  final String label;
  final IconData icon;
  final Function() onPressed;

  const ChecklistFabMenuItem({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton.small(
          heroTag: heroTag,
          onPressed: onPressed,
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
