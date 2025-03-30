import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/task_type.dart';

part 'task.freezed.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String title,
    required String? desc,
    required TaskType type,
    required bool isCompleted,
  }) = _Task;
}
