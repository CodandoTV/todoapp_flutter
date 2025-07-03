import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';
import 'package:todoapp/ui/screens/checklists/checklists_viewmodel.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';
import 'package:todoapp/ui/widgets/checklist/checklists_list_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'checklists_screen_state.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.checklists,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChecklistScreen(),
          ));
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
      body: ChecklistsListWidget(
        checklists: uiState.checklists,
        onRemoveChecklist: onRemoveChecklist,
        onSelectChecklist: (checklist) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TasksScreen(checklist: checklist),
          ),
        ),
      ),
    );
  }
}
