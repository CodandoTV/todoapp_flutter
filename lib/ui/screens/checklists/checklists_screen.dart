import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_full_widget.dart';
import 'package:todoapp/ui/components/widgets/checklist/checklist_navigation_rail_menu.dart';
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
    required Function() onPressed,
  }) {
    if (isBigSize) {
      return const SizedBox.shrink();
    } else {
      return FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.plus_one),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBigSize = MediaQuery.sizeOf(context).width > 600;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBarWidget(
          title: localizations.checklists,
        ),
        floatingActionButton: _buildFloatingActionButton(
          isBigSize: isBigSize,
          onPressed: () async {
            await _addNewChecklistEvent(context);
          },
        ),
        body: Row(
          children: [
            _buildNavigationRails(context: context, isBigSize: isBigSize),
            _buildVerticalSeparator(context: context, isBigSize: isBigSize),
            Expanded(
              child: _buildCheckListWidget(
                context: context,
                isBigSize: isBigSize,
              ),
            ),
          ],
        ));
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

  Widget _buildNavigationRails({
    required BuildContext context,
    required bool isBigSize,
  }) {
    if (isBigSize) {
      return ChecklistNavigationRailMenu(
        newChecklistIcon: Icons.plus_one,
        newChecklistLabel: 'New Checklist',
        newTaskIcon: Icons.add_task,
        newTaskLabel: 'New task',
        onNewTaskPressed: () async {
          /// Use key to access a specific internal behavior of TaskViewModel
          /// to update the task list through ChecklistFullWidget.
          final currentChecklistFullState = _checklistFullKey.currentState;
          currentChecklistFullState?.addNewTaskToExistingChecklist(
            context
          );
        },
        onNewChecklistPressed: () async {
          await _addNewChecklistEvent(context);
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildVerticalSeparator({
    required BuildContext context,
    required bool isBigSize,
  }) {
    if (isBigSize) {
      return const VerticalDivider(
        thickness: 0.2,
      );
    } else {
      return const SizedBox.shrink();
    }
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
