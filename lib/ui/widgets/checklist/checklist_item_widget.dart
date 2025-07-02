import 'package:flutter/material.dart';

import '../../../data/model/checklist.dart';

class ChecklistItemWidget extends StatelessWidget {
  final Checklist checklist;
  final Function(Checklist) onRemoveChecklist;
  final Function(int?) onSelectChecklist;

  const ChecklistItemWidget({
    super.key,
    required this.checklist,
    required this.onRemoveChecklist,
    required this.onSelectChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        onTap: () => onSelectChecklist(checklist.id),
        title: Text(checklist.title),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            onRemoveChecklist(checklist);
          },
        ),
      ),
    );
  }
}
