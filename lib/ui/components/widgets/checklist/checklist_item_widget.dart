import 'package:flutter/material.dart';

import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/components/widgets/card_wrapper_widget.dart';

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
    ShapeBorder shapeBorder = CardWrapperWidget.commonShapeBorder;
    double? elevation = CardWrapperWidget.commonElevation;

    if (isSelected == true) {
      backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
      shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      );
      elevation = null;
    }

    return CardWrapperWidget(
      onTap: () => onSelectChecklist(checklist),
      backgroundColor: backgroundColor,
      elevation: elevation,
      shapeBorder: shapeBorder,
      child: _internalContent(context, checklist),
    );
  }
}
