import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/data/model/task_type.dart';

@immutable
class Task extends Equatable {
  final String title;
  final String? desc;
  final TaskType type;
  final bool isCompleted;

  const Task({
    required this.title,
    this.desc,
    required this.type,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [title, desc, type, isCompleted];

  copyWith({required bool isCompleted}) {
    return Task(
      title: title,
      desc: desc,
      type: type,
      isCompleted: isCompleted,
    );
  }
}
