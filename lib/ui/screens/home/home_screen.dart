import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'home_screen_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel(getIt.get());
    viewModel.updateChecklists();

    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<HomeViewModel, HomeScreenState>(
        builder: (context, uiState) => _HomeScaffold(
          uiState: uiState,
        ),
      ),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  final HomeScreenState uiState;

  const _HomeScaffold({
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: AppLocalizations.of(context)!.tasks,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await context.push('/task');
          if (result == true) {
            // updateTasks();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.task_added,
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
      body: const SizedBox()
    );
  }
}
