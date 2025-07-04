// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get task => 'Tarefa';

  @override
  String get description => 'Descrição';

  @override
  String get tasks => 'Tarefas';

  @override
  String get empty_tasks => 'Nenhuma tarefa disponível';

  @override
  String get empty_checklists => 'Nenhum checklist disponível';

  @override
  String get task_name_required => 'Nome de tarefa é obrigatório';

  @override
  String get checklist_name_required => 'Nome de checklist é obrigatório';

  @override
  String get task_added => 'Tarefa adicionada.';

  @override
  String get checklist_added => 'Checklist adicionado.';

  @override
  String get remove_task_dialog_title => 'Remover tarefa';

  @override
  String get remove_task_dialog_desc =>
      'Você tem certeza que deseja remover essa tarefa?';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get checklists => 'Checklists';

  @override
  String get checklist => 'Checklist';

  @override
  String get checklist_name => 'Nome do Checklist';
}
