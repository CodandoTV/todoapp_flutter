
import 'package:equatable/equatable.dart';

import '../widgets/task/task_cell.dart';

class HomeScreenState extends Equatable {
  final List<TaskCell> taskUiModels;
  final showTrashIcon;

  const HomeScreenState(
      {required this.taskUiModels, required this.showTrashIcon});

  @override
  List<Object?> get props => [taskUiModels, showTrashIcon];

  HomeScreenState copy({List<TaskCell>? taskUiModels,bool? showTrashIcon}) {
    return HomeScreenState(
      taskUiModels: taskUiModels ?? this.taskUiModels,
      showTrashIcon: showTrashIcon ?? this.showTrashIcon,
    );
  }
}