import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todoapp/main.config.dart';
import 'package:todoapp/ui/todo_app.dart';

GetIt getIt = GetIt.instance;


@InjectableInit()
Future<void> configureDependencies() => getIt.init();

void main() {
  runApp(TodoApp());
}
