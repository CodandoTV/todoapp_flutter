import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/data/model/task.dart';

@immutable
class TasksScreenState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;

  const TasksScreenState({
    required this.tasks,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [
    tasks,
    isLoading,
  ];

  TasksScreenState copyWithIsLoading({
    required bool isLoading,
  }) {
    return TasksScreenState(
      tasks: tasks,
      isLoading: isLoading,
    );
  }
}
