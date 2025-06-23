import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/data/model/task.dart';

@immutable
class HomeScreenState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;

  const HomeScreenState({
    required this.tasks,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [
        tasks,
        isLoading,
      ];

  HomeScreenState copyWithIsLoading({
    required bool isLoading,
  }) {
    return HomeScreenState(
      tasks: tasks,
      isLoading: isLoading,
    );
  }
}
