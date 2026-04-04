import 'package:flutter/material.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class CheckAllActionChipWidget extends StatelessWidget {
  final TasksCompleteStatus? status;
  final VoidCallback onClick;

  const CheckAllActionChipWidget({
    super.key,
    required this.status,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    String text;
    if (status == null) {
      return const SizedBox.shrink();
    } else {
      switch (status!) {
        case TasksCompleteStatus.checkAll:
          text = localizations.check_all;
        case TasksCompleteStatus.uncheckAll:
          text = localizations.uncheck_all;
      }
      return Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: ActionChip(
          label: Text(text),
          onPressed: () {
            onClick();
          },
        ),
      );
    }
  }
}
