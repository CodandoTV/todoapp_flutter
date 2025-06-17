import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/task/task_cell.dart';

@immutable
class HomeScreenState extends Equatable {
  final List<TaskCell> taskUiModels;
  final bool showTrashIcon;
  final bool isLoading;

  const HomeScreenState({
    required this.taskUiModels,
    required this.showTrashIcon,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [
        taskUiModels,
        showTrashIcon,
        isLoading,
      ];

  HomeScreenState copyWithIsLoading({
    required bool isLoading,
  }) {
    return HomeScreenState(
      taskUiModels: taskUiModels,
      showTrashIcon: showTrashIcon,
      isLoading: isLoading,
    );
  }
}
