import 'package:flutter/material.dart';
import 'package:todoapp/ui/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/tasks',
          builder: (BuildContext context, GoRouterState state) {
            return const TasksScreen();
          },
        ),
        GoRoute(
          path: '/task',
          builder: (BuildContext context, GoRouterState state) {
            return const TaskScreen(taskUuid: null);
          },
        ),
      ],
    ),
  ],
);

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo list',
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 27, 121, 52),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 28, 165, 214),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
