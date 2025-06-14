import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/data/todo_in_memory_data_source.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/todo_app.dart';

import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/task_type.dart';

TodoInMemoryDataSource _todoInMemoryDataSource = TodoInMemoryDataSource([
  const Task(
    title: 'Buy guinea pig foooo',
    type: TaskType.pet,
    desc: 'Should buy x',
    isCompleted: false,
  ),
  const Task(
    title: 'Buy dog food',
    type: TaskType.pet,
    desc: null,
    isCompleted: false,
  ),
  const Task(
    title: 'Wash the sdccsd',
    type: TaskType.chores,
    desc: null,
    isCompleted: false,
  ),
]);

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<TodoInMemoryDataSource>(_todoInMemoryDataSource);
  getIt.registerFactory(() => TodoRepository(getIt<TodoInMemoryDataSource>()));

  runApp(
    const TodoApp(),
  );
}
