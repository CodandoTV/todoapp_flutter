import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/ui/todo_app_router_config.gr.dart';
import 'package:todoapp/util/di/dependency_startup_launcher.dart';

@RoutePage()
class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StackRouter? _stackRouter;

  @override
  void initState() {
    super.initState();
    _loadDependencies();
  }

  Future<void> _loadDependencies() async {
    await GetItStartupHandlerWrapper.init();
    _stackRouter?.replace(const ChecklistsRoute());
  }

  @override
  Widget build(BuildContext context) {
    _stackRouter = AutoRouter.of(context);
    return const StartupContainer(
      isLoading: true,
    );
  }
}

class StartupContainer extends StatelessWidget {
  final bool isLoading;

  const StartupContainer({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: isLoading ? const CircularProgressIndicator() : null,
      ),
    );
  }
}
