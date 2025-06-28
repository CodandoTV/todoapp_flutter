import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/main.config.dart';
import 'package:todoapp/ui/todo_app.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getIt.init();

  runApp(
    const TodoApp(),
  );
}
