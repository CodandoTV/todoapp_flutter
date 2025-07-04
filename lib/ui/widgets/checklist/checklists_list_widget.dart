import 'package:flutter/material.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/widgets/checklist/checklist_item_widget.dart';

import '../../l10n/app_localizations.dart';

class ChecklistsListWidget extends StatelessWidget {
  final List<Checklist> checklists;
  final Function(Checklist) onRemoveChecklist;
  final Function(Checklist) onSelectChecklist;

  const ChecklistsListWidget({
    super.key,
    required this.checklists,
    required this.onRemoveChecklist,
    required this.onSelectChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTaskList(context);
  }

  Widget _buildTaskList(BuildContext context) {
    if (checklists.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.empty_checklists,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      return GridView.count(
        padding: const EdgeInsets.only(
          bottom: 90
        ),
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        children: List.generate(checklists.length, (index) {
          return ChecklistItemWidget(
            checklist: checklists[index],
            onRemoveChecklist: onRemoveChecklist,
            onSelectChecklist: onSelectChecklist,
          );
        }),
      );
    }
  }
}
