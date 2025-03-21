import 'package:flutter/foundation.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/ui/widgets/task_type_extension.dart';

import '../../data/model/task.dart';
import '../widgets/task/task_cell.dart';
import 'home_screen_state.dart';

class HomeViewModel extends ChangeNotifier {
  late TodoRepository _repository;

  List<Task> _deleteTasksBuffer = [];

  var uiState = const HomeScreenState(
    taskUiModels: [],
    showTrashIcon: false,
  );

  HomeViewModel(
    TodoRepository repository,
  ) {
    _repository = repository;
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
    uiState = HomeScreenState(
      taskUiModels: taskCells,
      showTrashIcon: _deleteTasksBuffer.isNotEmpty,
    );
    notifyListeners();
  }

  void onCompleteTask(TaskCell taskCell, bool value) async {
    var index = uiState.taskUiModels.indexOf(taskCell);
    if (index != -1) {
      var result = await _repository.update(
        uiState.taskUiModels[index].task,
        value,
      );

      if (result) {
        final taskUpdated = uiState.taskUiModels[index].task.copy(
          isCompleted: value,
        );
        final uiModels = List.of(uiState.taskUiModels);
        uiModels[index] = uiState.taskUiModels[index].copy(task: taskUpdated);

        uiState = HomeScreenState(
          taskUiModels: uiModels,
          showTrashIcon: uiState.showTrashIcon,
        );
        notifyListeners();
      }
    }
  }

  void onRemoveTask(Task task) {
    var taskCellToBeDeletedIndex =
        uiState.taskUiModels.indexWhere((taskCell) => taskCell.task == task);
    if (taskCellToBeDeletedIndex != -1) {
      var newSelectionValue =
          !uiState.taskUiModels[taskCellToBeDeletedIndex].isSelected;
      if (newSelectionValue) {
        _deleteTasksBuffer.add(task);
      } else {
        _deleteTasksBuffer.remove(task);
      }

      final uiModels = List.of(uiState.taskUiModels);
      uiModels[taskCellToBeDeletedIndex] =
          uiState.taskUiModels[taskCellToBeDeletedIndex].copy(
        isSelected: newSelectionValue,
      );

      uiState = HomeScreenState(
        taskUiModels: uiModels,
        showTrashIcon: _deleteTasksBuffer.isNotEmpty,
      );
      notifyListeners();
    }
  }
}
