import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/checklists/checklists_viewmodel.dart';
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
        ),
      ),
    );
  }
}

class _ChecklistsScaffold extends StatelessWidget {
  final ChecklistsScreenState uiState;

  const _ChecklistsScaffold({
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.checklists,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: const SizedBox()
    );
  }
}
