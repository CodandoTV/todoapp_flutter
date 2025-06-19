import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class TaskScreenState extends Equatable {
  final List<String> categoryNames;

  const TaskScreenState({
    required this.categoryNames,
  });

  @override
  List<Object?> get props => [categoryNames];
}
