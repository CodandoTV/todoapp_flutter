import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_expandable_fab_menu.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_full_widget.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklists_list_widget.dart';
import 'package:todoapp/ui/components/widgets/confirmation_alert_dialog_widget.dart';
import 'package:todoapp/ui/components/widgets/custom_app_bar_widget.dart';
import 'package:todoapp/ui/l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen_state.dart';
import 'package:todoapp/ui/screens/checklists/checklists_viewmodel.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';
import 'package:todoapp/util/navigation_provider.dart';

@RoutePage()
class ChecklistsScreen extends StatelessWidget {
  const ChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ChecklistsViewModel(
      GetItStartupHandlerWrapper.getIt.get(),
    );
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

  /// Use key to access a specific internal behavior of TaskViewModel
  /// to update the task list through ChecklistFullWidget.
  final GlobalKey<ChecklistsListFullWidgetState> _checklistFullKey =
      GlobalKey<ChecklistsListFullWidgetState>();

  ChecklistsScaffold({
    super.key,
    required this.uiState,
    required this.updateChecklists,
    required this.onRemoveChecklist,
    required this.navigatorProvider,
  });

  Widget _buildFloatingActionButton({
    required bool isBigSize,
    required BuildContext context,
  }) {
    if (isBigSize) {
      return ChecklistExpandableFabMenu(
        onNewChecklistPressed: () async {
          await _addNewChecklistEvent(context);
        },
        onNewTaskPressed: () async {
          /// Use key to access a specific internal behavior of
          /// TaskViewModel to update the task list through
          /// ChecklistFullWidget.
          final currentChecklistFullState = _checklistFullKey.currentState;
          currentChecklistFullState?.addNewTaskToExistingChecklist(context);
        },
      );
    } else {
      return FloatingActionButton(
        onPressed: () async {
          await _addNewChecklistEvent(context);
        },
        child: const Icon(Icons.plus_one),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBigSize = MediaQuery.sizeOf(context).width > 600;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButtonLocation: isBigSize ? ExpandableFab.location : null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: localizations.checklists,
      ),
      floatingActionButton: _buildFloatingActionButton(
        isBigSize: isBigSize,
        context: context,
      ),
      body: _buildCheckListWidget(
        context: context,
        isBigSize: isBigSize,
      ),
    );
  }

  Widget _buildCheckListWidget({
    required BuildContext context,
    required bool isBigSize,
  }) {
    final localizations = AppLocalizations.of(context)!;

    Widget checkListWidget;
    if (isBigSize) {
      checkListWidget = ChecklistsListFullWidget(
        checklists: uiState.checklists,
        key: _checklistFullKey,
        onRemoveChecklist: (checklist) {
          _showConfirmationDialogToRemoveChecklist(context, checklist);
        },
        navigatorProvider: navigatorProvider,
      );
    } else {
      checkListWidget = ChecklistsListWidget(
        checklists: uiState.checklists,
        emptyChecklistMessage: localizations.empty_checklists,
        onRemoveChecklist: (checklist) {
          _showConfirmationDialogToRemoveChecklist(context, checklist);
        },
        onSelectChecklist: (checklist) => navigatorProvider.push(
          context,
          TasksRoute(checklist: checklist),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: checkListWidget,
    );
  }

  void _showConfirmationDialogToRemoveChecklist(
    BuildContext context,
    Checklist checklist,
  ) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationAlertDialogWidget(
        title: localizations.remove_checklist_dialog_title,
        description: localizations.remove_checklist_dialog_desc,
        secondaryButtonText: localizations.no,
        primaryButtonText: localizations.yes,
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

  Future<void> _addNewChecklistEvent(BuildContext context) async {
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
  }
}
