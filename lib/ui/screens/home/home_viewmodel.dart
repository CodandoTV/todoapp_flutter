import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/widgets/task_type_extension.dart';

import '../../../data/model/task.dart';
import '../../widgets/task/task_cell.dart';
import 'home_screen_state.dart';

class HomeViewModel extends Cubit<HomeScreenState> {
  late TodoRepository _repository;
  List<Task> _deleteTasksBuffer = [];

  HomeViewModel(
    TodoRepository repository,
  ) : super(
          const HomeScreenState(
            taskUiModels: [],
            showTrashIcon: false,
            isLoading: true,
          ),
        ) {
    _repository = repository;
  }

  void _onLoad() {
    emit(
      state.copyWithIsLoading(isLoading: true),
    );
  }

  void deleteSelectedTasks() async {
    _onLoad();

    await _repository.delete(_deleteTasksBuffer);
    _deleteTasksBuffer = [];

    await updateTasks();
  }

  Future<void> updateTasks() async {
    _onLoad();

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
        isLoading: false,
        taskUiModels: taskCells,
        showTrashIcon: _deleteTasksBuffer.isNotEmpty,
      ),
    );
  }

  void onCompleteTask(TaskCell taskCell, bool value) async {
    _onLoad();

    var index = state.taskUiModels.indexOf(taskCell);
    if (index != -1) {
      var result = await _repository.update(
        state.taskUiModels[index].task,
        value,
      );

      if (result) {
        final taskUpdated = state.taskUiModels[index].task.copyWithIsComplete(
          isCompleted: value,
        );
        final uiModels = List.of(state.taskUiModels);
        uiModels[index] = state.taskUiModels[index].copyWithTask(
          taskUpdated,
        );

        emit(
          HomeScreenState(
            isLoading: false,
            taskUiModels: uiModels,
            showTrashIcon: state.showTrashIcon,
          ),
        );
      }
    }
  }

  void onRemoveTask(Task task) {
    _onLoad();

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
      uiModels[taskCellToBeDeletedIndex] =
          state.taskUiModels[taskCellToBeDeletedIndex].copyWithIsSelected(
        newSelectionValue,
      );

      emit(
        HomeScreenState(
          isLoading: false,
          taskUiModels: uiModels,
          showTrashIcon: _deleteTasksBuffer.isNotEmpty,
        ),
      );
    }
  }
}
