import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/task.dart';

part 'tasks_screen_state.freezed.dart';

@freezed
class TasksScreenState with _$TasksScreenState {
  final List<Task> tasks;
  final bool isLoading;

  const TasksScreenState({
    required this.tasks,
    required this.isLoading,
  });
}
