import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';

part 'tasks_screen_state.freezed.dart';

@freezed
class TasksScreenState with _$TasksScreenState {
  @override
  final List<Task> tasks;
  @override
  final bool isLoading;
  @override
  final double progress;
  @override
  final bool showShareIcon;

  @override
  final TasksCompleteStatus? tasksCompleteStatus;

  const TasksScreenState({
    required this.tasks,
    required this.isLoading,
    required this.progress,
    required this.showShareIcon,
    this.tasksCompleteStatus,
  });
}
