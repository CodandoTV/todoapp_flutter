import 'package:flutter/material.dart';
import 'package:todoapp/generated/app_localizations.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      home: const ChecklistsScreen(),
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
