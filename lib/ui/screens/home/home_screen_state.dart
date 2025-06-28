import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/task.dart';

part 'home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  final List<Task> tasks;
  final bool isLoading;

  const HomeScreenState({
    required this.tasks,
    required this.isLoading,
  });
}
