import 'package:flutter/material.dart';

import '../../../data/model/checklist.dart';

class ChecklistItemWidget extends StatelessWidget {
  final Checklist checklist;
  final Function(Checklist) onRemoveChecklist;
  final Function(Checklist) onSelectChecklist;

  const ChecklistItemWidget({
    super.key,
    required this.checklist,
    required this.onRemoveChecklist,
    required this.onSelectChecklist,
  });

  Widget _internalContent(
    BuildContext context,
    Checklist checklist,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          checklist.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () => {
                onRemoveChecklist(checklist)
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceBright,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onSelectChecklist(checklist),
        child: _internalContent(context, checklist),
      ),
    );
  }
}
