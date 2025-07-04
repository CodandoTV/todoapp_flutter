// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get task => 'Task';

  @override
  String get description => 'Description';

  @override
  String get tasks => 'Tasks';

  @override
  String get empty_tasks => 'No tasks available';

  @override
  String get empty_checklists => 'No checklists available';

  @override
  String get task_name_required => 'Task name is required';

  @override
  String get checklist_name_required => 'Checklist name is required';

  @override
  String get task_added => 'Task was added.';

  @override
  String get checklist_added => 'Checklist was added.';

  @override
  String get remove_task_dialog_title => 'Remove task';

  @override
  String get remove_task_dialog_desc =>
      'Are you sure you want to remove this task?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get checklists => 'Checklists';

  @override
  String get checklist => 'Checklist';

  @override
  String get checklist_name => 'Checklist name';
}
