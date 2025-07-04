import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';

import '../../../data/model/task.dart';

class TasksViewModel extends Cubit<TasksScreenState> {
  late TodoRepository _repository;
  late int? _checklistId;

  TasksViewModel(
    TodoRepository repository,
    int? checklistId,
  ) : super(
          const TasksScreenState(
            tasks: [],
            isLoading: true,
          ),
        ) {
    _repository = repository;
    _checklistId = checklistId;
  }

  void _onLoad() {
    emit(
      state.copyWith(isLoading: true),
    );
  }

  Future<void> updateTasks() async {
    _onLoad();

    var tasks = await _repository.getTasks(_checklistId);
    emit(
      TasksScreenState(
        isLoading: false,
        tasks: tasks,
      ),
    );
  }

  Future<void> onCompleteTask(Task task, bool value) async {
    _onLoad();

    var result = await _repository.updateTask(
      task,
      value,
    );

    if (result == true) {
      List<Task> tasks = List.from(state.tasks);
      var index = state.tasks.indexWhere((item) => item.id == task.id);
      if (index != -1) {
        tasks[index] = tasks[index].copyWith(isCompleted: value);
        emit(
          TasksScreenState(
            isLoading: false,
            tasks: tasks,
          ),
        );
      }
    }
  }

  Future<void> onRemoveTask(Task task) async {
    _onLoad();

    var result = await _repository.deleteTasks([task]);

    if (result) {
      List<Task> tasks = List.from(state.tasks);
      tasks.remove(task);
      emit(
        TasksScreenState(
          isLoading: false,
          tasks: tasks,
        ),
      );
    }
  }

  reorder(int oldIndex, int newIndex) async {
    List<Task> tasks = List.from(state.tasks);
    var task = tasks.removeAt(oldIndex);

    // If moving down the list,
    // adjust newIndex to account for the removed item
    if (newIndex > oldIndex) {
      newIndex--;
    }

    tasks.insert(newIndex, task);

    emit(
      TasksScreenState(
        isLoading: false,
        tasks: tasks,
      ),
    );

    _repository.updateAllTasks(tasks);
  }
}
