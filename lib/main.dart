import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/data/todo_in_memory_data_source.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/todo_app.dart';

import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/task_type.dart';

TodoInMemoryDataSource _todoInMemoryDataSource = TodoInMemoryDataSource([
  const Task(
    title: 'Buy guinea pig food',
    type: TaskType.pet,
    desc: 'Should buy megazoo',
    isCompleted: false,
  ),
  const Task(
      title: 'Buy dog food',
      type: TaskType.pet,
      desc: null,
      isCompleted: false),
  const Task(
      title: 'Wash the dishes',
      type: TaskType.chores,
      desc: null,
      isCompleted: false),
]);

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
