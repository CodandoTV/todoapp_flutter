import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Task extends Equatable {
  final int? id;
  final String title;
  final String? desc;
  final String type;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    this.desc,
    required this.type,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, desc, type, isCompleted];

  copyWithIsComplete({required bool isCompleted}) {
    return Task(
      id: id,
      title: title,
      desc: desc,
      type: type,
      isCompleted: isCompleted,
    );
  }
}
