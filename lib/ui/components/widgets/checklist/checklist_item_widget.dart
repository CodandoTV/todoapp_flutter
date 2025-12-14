import 'package:flutter/material.dart';

import 'package:todoapp/data/model/checklist.dart';

class ChecklistItemWidget extends StatelessWidget {
  final Checklist checklist;
  final Function(Checklist) onRemoveChecklist;
  final Function(Checklist) onSelectChecklist;
  final bool? isSelected;

  const ChecklistItemWidget({
    super.key,
    this.isSelected,
    required this.checklist,
    required this.onRemoveChecklist,
    required this.onSelectChecklist,
  });

  Widget _internalContent(
    BuildContext context,
    Checklist checklist,
  ) {
    return ListTile(
      leading: IconButton(
        onPressed: () => onRemoveChecklist(checklist),
        icon: const Icon(Icons.close),
      ),
      title: Text(
        checklist.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.surfaceBright;

    if (isSelected == true) {
      backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
    }

    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onSelectChecklist(checklist),
        child: _internalContent(context, checklist),
      ),
    );
  }
}
