import 'package:flutter/material.dart';
import 'package:todoapp/ui/generated/app_localizations.dart';
import 'package:todoapp/ui/screens/checklists/checklists_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color.fromARGB(255, 239, 232, 215);
    return MaterialApp(
      title: 'Todo list',
      home: const ChecklistsScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: baseColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
