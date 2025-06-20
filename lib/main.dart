import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/data/database/data_base_builder.dart';
import 'package:todoapp/data/database/todo_category_dao.dart';
import 'package:todoapp/data/database/todo_dao.dart';
import 'package:todoapp/data/database/todo_data_base.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/todo_app.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DataBaseBuilder.build();
  final database = TodoDataBase(db);

  getIt.registerSingleton<TodoDataBase>(database);

  getIt.registerSingleton<TodoDAO>(TodoDAO(getIt<TodoDataBase>()));

  getIt.registerSingleton<TodoCategoryDAO>(TodoCategoryDAO(
    getIt<TodoDataBase>(),
  ));

  getIt.registerFactory<TodoRepository>(() => TodoRepositoryImpl(
        getIt<TodoDAO>(),
        getIt<TodoCategoryDAO>(),
      ));

  runApp(
    const TodoApp(),
  );
}
