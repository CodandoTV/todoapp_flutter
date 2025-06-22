import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Task extends Equatable {
  final int? id;
  final String title;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, isCompleted];

  copyWithIsComplete({required bool isCompleted}) {
    return Task(
      id: id,
      title: title,
      isCompleted: isCompleted,
    );
  }
}
