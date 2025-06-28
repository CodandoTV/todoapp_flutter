import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_screen_state.freezed.dart';

@freezed
class TaskScreenState with _$TaskScreenState {
  final List<String> categoryNames;

  const TaskScreenState({
    required this.categoryNames,
  });

}
