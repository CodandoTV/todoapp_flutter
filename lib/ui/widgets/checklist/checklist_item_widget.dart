import 'package:flutter/material.dart';

import '../../../data/model/checklist.dart';

class ChecklistItemWidget extends StatelessWidget {
  final Checklist checklist;
  final Function(Checklist) onRemoveChecklist;

  const ChecklistItemWidget({
    super.key,
    required this.checklist,
    required this.onRemoveChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(checklist.title),
    );
  }
}
