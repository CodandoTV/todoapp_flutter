import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/data/database/data_base_builder.dart';
import 'package:todoapp/data/database/todo_dao.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/screens/task/task_screen_validator.dart';
import 'package:todoapp/ui/todo_app.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DataBaseBuilder.build();
  getIt.registerSingleton<TodoDAO>(TodoDAO(db));
  getIt.registerFactory(() => TaskScreenValidator());
  getIt.registerFactory<TodoRepository>(() => TodoRepositoryImpl(
        getIt<TodoDAO>(),
      ));

  runApp(
    const TodoApp(),
  );
}
