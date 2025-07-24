import 'package:flutter/material.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/widgets/checklist/checklist_item_widget.dart';

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
      return ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 120),
        itemBuilder: (context, index) => ChecklistItemWidget(
            checklist: checklists[index],
            onRemoveChecklist: onRemoveChecklist,
            onSelectChecklist: onSelectChecklist,
        ),
        itemCount: checklists.length,
      );
    }
  }
}
