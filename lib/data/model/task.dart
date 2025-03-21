import 'package:equatable/equatable.dart';
import 'package:todo_app/data/model/task_type.dart';

class Task extends Equatable {
  final String title;
  final String? desc;
  final TaskType type;
  final bool isCompleted;

  const Task({
    required this.title,
    required this.desc,
    required this.type,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [title, desc, type, isCompleted];

  Task copy({
    String? title,
    String? desc,
    TaskType? type,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
