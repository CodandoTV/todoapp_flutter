import 'package:flutter/material.dart';
import 'package:todoapp/ui/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/ui/screens/task/task_screen.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
    );
  }
}
