import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/ui/screens/checklist/checklist_screen.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen.dart';

import 'l10n/app_localizations.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ChecklistsScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/tasks',
          builder: (BuildContext context, GoRouterState state) {
            int? checklistId = state.extra as int?;
            return TasksScreen(
              checklistId: checklistId,
            );
          },
        ),
        GoRoute(
          path: '/task',
          builder: (BuildContext context, GoRouterState state) {
            int? checklistId = state.extra as int?;
            return TaskScreen(
              checklistId: checklistId,
            );
          },
        ),
        GoRoute(
          path: '/checklist',
          builder: (BuildContext context, GoRouterState state) {
            return const ChecklistScreen(checkListUuid: null);
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
