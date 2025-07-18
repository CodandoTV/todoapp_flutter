import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/checklists/checklists_viewmodel.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/ui/widgets/checklist/checklists_list_widget.dart';
import 'package:todoapp/ui/widgets/confirmation_alert_dialog_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'checklists_screen_state.dart';

@RoutePage()
class ChecklistsScreen extends StatelessWidget {
  const ChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ChecklistsViewModel(getIt.get());
    viewModel.updateChecklists();

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<ChecklistsViewModel, ChecklistsScreenState>(
        builder: (context, uiState) => _ChecklistsScaffold(
          uiState: uiState,
          updateChecklists: viewModel.updateChecklists,
          onRemoveChecklist: viewModel.onRemoveChecklist,
        ),
      ),
    );
  }
}

class _ChecklistsScaffold extends StatelessWidget {
  final ChecklistsScreenState uiState;
  final Function(Checklist) onRemoveChecklist;
  final Function updateChecklists;

  const _ChecklistsScaffold({
    required this.uiState,
    required this.updateChecklists,
    required this.onRemoveChecklist,
  });

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.checklists,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await router.push(const ChecklistRoute());

          if (result == true) {
            updateChecklists();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.checklist_added,
                  ),
                ),
              );
            }
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ChecklistsListWidget(
          checklists: uiState.checklists,
          onRemoveChecklist: (checklist) {
            _showConfirmationDialogToRemoveChecklist(context, checklist);
          },
          onSelectChecklist: (checklist) => router.push(
            TasksRoute(checklist: checklist),
          ),
        ),
      ),
    );
  }

  _showConfirmationDialogToRemoveChecklist(
    BuildContext context,
    Checklist checklist,
  ) {
    final router = AutoRouter.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationAlertDialogWidget(
        title: appLocalizations.remove_checklist_dialog_title,
        description: appLocalizations.remove_checklist_dialog_desc,
        secondaryButtonText: appLocalizations.no,
        primaryButtonText: appLocalizations.yes,
        onSecondaryButtonPressed: () => {
          router.pop(),
        },
        onPrimaryButtonPressed: () =>
            {router.pop(), onRemoveChecklist(checklist)},
      ),
    );
  }
}
