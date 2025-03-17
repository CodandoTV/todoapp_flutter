import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/todo_in_memory_data_source.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/presentation/todo_app.dart';

TodoInMemoryDataSource _todoInMemoryDataSource = TodoInMemoryDataSource();

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => _todoInMemoryDataSource),
        Provider(create: (context) => TodoRepository(context.read())),
      ],
      child: const TodoApp(),
    ),
  );
}
