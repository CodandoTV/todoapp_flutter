import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/usecases/delete_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/widgets/task_type_extension.dart';

import '../../domain/model/task.dart';
import '../widgets/task/task_cell.dart';

class HomeScreenState {
  List<TaskCell> taskUiModels;
  var showTrashIcon;

  HomeScreenState({required this.taskUiModels, required this.showTrashIcon});
}

class HomeScreenCubit extends Cubit<HomeScreenState> {
  late GetTasksUseCase _getTasksUseCase;
  late UpdateTaskStatusUseCase _updateTaskStatusUseCase;
  late DeleteTasksUseCase _deleteTasksUseCase;

  List<Task> _deleteTasksBuffer = [];

  HomeScreenCubit(
      GetTasksUseCase getTasksUseCase,
      UpdateTaskStatusUseCase updateTaskStatusUseCase,
      DeleteTasksUseCase deleteTasksUseCase)
      : super(HomeScreenState(taskUiModels: [], showTrashIcon: false)) {
    _getTasksUseCase = getTasksUseCase;
    _updateTaskStatusUseCase = updateTaskStatusUseCase;
    _deleteTasksUseCase = deleteTasksUseCase;

    updateTasks();
  }

  void deleteSelectedTasks() {
    _deleteTasksUseCase.delete(_deleteTasksBuffer);
    _deleteTasksBuffer = [];

    updateTasks();
  }

  void updateTasks() async {
    var tasks = await _getTasksUseCase.get();
    var taskCells = tasks.map((element) => element.toTaskCell()).toList();
    for (var taskCell in taskCells) {
      taskCell.isSelected = _deleteTasksBuffer.contains(taskCell.task);
    }

    emit(HomeScreenState(
        taskUiModels: taskCells, showTrashIcon: _deleteTasksBuffer.isNotEmpty));
  }

  void onCheckChanged(TaskCell taskCell, bool value) async {
    var index = state.taskUiModels.indexOf(taskCell);
    if (index != -1) {
      var result = await _updateTaskStatusUseCase.update(
        state.taskUiModels[index].task,
        value,
      );

      if (result) {
        var taskUiCell = state.taskUiModels[index]..task.isCompleted = value;

        state.taskUiModels[index] = taskUiCell;

        emit(
          HomeScreenState(
            taskUiModels: state.taskUiModels,
            showTrashIcon: state.showTrashIcon,
          ),
        );
      }
    }
  }

  void onTaskLongPressed(Task task) {
    var taskCellToBeDeletedIndex =
        state.taskUiModels.indexWhere((taskCell) => taskCell.task == task);
    if (taskCellToBeDeletedIndex != -1) {
      var taskCellTarget = state.taskUiModels[taskCellToBeDeletedIndex];

      var newSelectionValue = !taskCellTarget.isSelected;

      if (newSelectionValue) {
        _deleteTasksBuffer.add(task);
      } else {
        _deleteTasksBuffer.remove(task);
      }

      state.taskUiModels[taskCellToBeDeletedIndex] = TaskCell(
        icon: taskCellTarget.icon,
        isSelected: newSelectionValue,
        task: taskCellTarget.task,
      );

      emit(
        HomeScreenState(
            taskUiModels: state.taskUiModels,
            showTrashIcon: _deleteTasksBuffer.isNotEmpty),
      );
    }
  }
}
