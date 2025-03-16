import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/todo_in_memory_data_source.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/domain/usecases/add_new_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/get_categories_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/todo_app.dart';

TodoInMemoryDataSource _todoInMemoryDataSource = TodoInMemoryDataSource();

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => _todoInMemoryDataSource),
        Provider(create: (context) => TodoRepository(context.read())),
        Provider(create: (context) => AddNewTaskUseCase(context.read())),
        Provider(create: (context) => DeleteTasksUseCase(context.read())),
        Provider(create: (_) => GetCategoriesUseCase()),
        Provider(create: (context) => GetTasksUseCase(context.read())),
        Provider(create: (context) => UpdateTaskStatusUseCase(context.read())),
      ],
      child: const TodoApp(),
    ),
  );
}
