import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/todo_repository.dart';

import '../../../data/model/task.dart';
import 'home_screen_state.dart';

class HomeViewModel extends Cubit<HomeScreenState> {
  late TodoRepository _repository;

  HomeViewModel(
    TodoRepository repository,
  ) : super(
          const HomeScreenState(
            tasks: [],
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

  Future<void> updateTasks() async {
    _onLoad();

    var tasks = await _repository.getTasks();
    emit(
      HomeScreenState(
        isLoading: false,
        tasks: tasks,
      ),
    );
  }

  Future<void> onCompleteTask(Task task, bool value) async {
    _onLoad();

    var result = await _repository.update(
      task,
      value,
    );

    if (result == true) {
      List<Task> tasks = List.from(state.tasks);
      var index = state.tasks.indexOf(task);
      if (index != -1) {
        tasks[index] = tasks[index].copyWithIsComplete(isCompleted: value);
        emit(
          HomeScreenState(
            isLoading: false,
            tasks: tasks,
          ),
        );
      }
    }
  }

  Future<void> onRemoveTask(Task task) async {
    _onLoad();

    var result = await _repository.delete([task]);

    if (result) {
      List<Task> tasks = List.from(state.tasks);
      tasks.remove(task);
      emit(
        HomeScreenState(
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
    if(newIndex > oldIndex) {
      newIndex--;
    }

    tasks.insert(newIndex, task);

    emit(
      HomeScreenState(
        isLoading: false,
        tasks: tasks,
      ),
    );
  }
}
