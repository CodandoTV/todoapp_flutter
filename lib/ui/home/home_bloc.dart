import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/ui/widgets/task_type_extension.dart';

import '../../data/model/task.dart';
import '../widgets/task/task_cell.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Cubit<HomeScreenState> {
  late TodoRepository _repository;

  List<Task> _deleteTasksBuffer = [];

  HomeScreenBloc(
    TodoRepository repository,
  ) : super(const HomeScreenState(taskUiModels: [], showTrashIcon: false)) {
    _repository = repository;
    updateTasks();
  }

  void deleteSelectedTasks() {
    _repository.delete(_deleteTasksBuffer);
    _deleteTasksBuffer = [];

    updateTasks();
  }

  void updateTasks() async {
    var tasks = await _repository.getTasks();
    var taskCells = tasks
        .map(
          (element) => element.toTaskCell(
            _deleteTasksBuffer.contains(element),
          ),
        )
        .toList();
    emit(
      HomeScreenState(
        taskUiModels: taskCells,
        showTrashIcon: _deleteTasksBuffer.isNotEmpty,
      ),
    );
  }

  void onCompleteTask(TaskCell taskCell, bool value) async {
    var index = state.taskUiModels.indexOf(taskCell);
    if (index != -1) {
      var result = await _repository.update(
        state.taskUiModels[index].task,
        value,
      );

      if (result) {
        final taskUpdated = state.taskUiModels[index].task.copy(
          isCompleted: value,
        );
        final uiModels = List.of(state.taskUiModels);
        uiModels[index] = state.taskUiModels[index].copy(task: taskUpdated);

        emit(
          HomeScreenState(
            taskUiModels: uiModels,
            showTrashIcon: state.showTrashIcon,
          ),
        );
      }
    }
  }

  void onRemoveTask(Task task) {
    var taskCellToBeDeletedIndex =
        state.taskUiModels.indexWhere((taskCell) => taskCell.task == task);
    if (taskCellToBeDeletedIndex != -1) {
      var newSelectionValue =
          !state.taskUiModels[taskCellToBeDeletedIndex].isSelected;
      if (newSelectionValue) {
        _deleteTasksBuffer.add(task);
      } else {
        _deleteTasksBuffer.remove(task);
      }

      final uiModels = List.of(state.taskUiModels);
      uiModels[taskCellToBeDeletedIndex] = state.taskUiModels[taskCellToBeDeletedIndex].copy(
        isSelected: newSelectionValue,
      );

      emit(
        HomeScreenState(
          taskUiModels: uiModels,
          showTrashIcon: _deleteTasksBuffer.isNotEmpty,
        ),
      );
    }
  }
}
