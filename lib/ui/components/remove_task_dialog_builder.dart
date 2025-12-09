import 'package:flutter/cupertino.dart';
import 'package:todoapp/ui/components/widgets/confirmation_alert_dialog_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';

class RemoveTaskDialogBuilder {

  static ConfirmationAlertDialogWidget build({
    required BuildContext context,
    required VoidCallback onPrimaryButtonPressed,
    required VoidCallback onSecondaryButtonPressed,
  }) {
    final localizations = AppLocalizations.of(context)!;

    return ConfirmationAlertDialogWidget(
      title: localizations.remove_task_dialog_title,
      description: localizations.remove_task_dialog_desc,
      secondaryButtonText: localizations.no,
      primaryButtonText: localizations.yes,
      onSecondaryButtonPressed: onSecondaryButtonPressed,
      onPrimaryButtonPressed: onPrimaryButtonPressed,
    );
  }
}
