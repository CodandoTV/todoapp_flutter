import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/task/task_cell.dart';

@immutable
class HomeScreenState extends Equatable {
  final List<TaskCell> taskUiModels;
  final bool showTrashIcon;

  const HomeScreenState({
    required this.taskUiModels,
    required this.showTrashIcon,
  });

  @override
  List<Object?> get props => [
        taskUiModels,
        showTrashIcon,
      ];
}
