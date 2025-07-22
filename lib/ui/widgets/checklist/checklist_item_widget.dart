import 'package:flutter/material.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

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
    return ListTile(
      title: Text(
        checklist.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: IconButton(
        onPressed: () => onRemoveChecklist(checklist),
        icon: const Icon(Icons.delete),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _internalContent(context, checklist),
        ),
      ),
    );
  }
}
