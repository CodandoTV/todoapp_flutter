import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/components/providers/navigation_provider.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/checklists/checklists_viewmodel.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/ui/widgets/checklist/checklists_list_widget.dart';
import 'package:todoapp/ui/widgets/confirmation_alert_dialog_widget.dart';
import '../../../util/di/dependency_startup_handler.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'checklists_screen_state.dart';

@RoutePage()
class ChecklistsScreen extends StatelessWidget {
  const ChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        ChecklistsViewModel(GetItStartupHandlerWrapper.getIt.get());
    viewModel.updateChecklists();

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<ChecklistsViewModel, ChecklistsScreenState>(
        builder: (context, uiState) => ChecklistsScaffold(
          uiState: uiState,
          updateChecklists: viewModel.updateChecklists,
          onRemoveChecklist: viewModel.onRemoveChecklist,
          navigatorProvider: GetItStartupHandlerWrapper.getIt.get(),
        ),
      ),
    );
  }
}

class ChecklistsScaffold extends StatelessWidget {
  final ChecklistsScreenState uiState;
  final Function(Checklist) onRemoveChecklist;
  final Function updateChecklists;
  final NavigatorProvider navigatorProvider;

  const ChecklistsScaffold({
    super.key,
    required this.uiState,
    required this.updateChecklists,
    required this.onRemoveChecklist,
    required this.navigatorProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.checklists,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await navigatorProvider.push(
            context,
            const ChecklistRoute(),
          );

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
          onSelectChecklist: (checklist) => navigatorProvider.push(
            context,
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
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationAlertDialogWidget(
        title: appLocalizations.remove_checklist_dialog_title,
        description: appLocalizations.remove_checklist_dialog_desc,
        secondaryButtonText: appLocalizations.no,
        primaryButtonText: appLocalizations.yes,
        onSecondaryButtonPressed: () => {
          navigatorProvider.onPop(context, null),
        },
        onPrimaryButtonPressed: () => {
          navigatorProvider.onPop(context, null),
          onRemoveChecklist(checklist)
        },
      ),
    );
  }
}
