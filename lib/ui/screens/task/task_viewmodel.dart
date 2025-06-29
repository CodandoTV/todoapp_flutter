import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/ui/screens/task/task_screen_state.dart';

import '../../../data/model/task.dart';
import '../../../data/todo_repository.dart';

class TaskViewModel extends Cubit<TaskScreenState> {
  late TodoRepository _repository;

  TaskViewModel(TodoRepository repository)
      : super(
          const TaskScreenState(
            categoryNames: [],
          ),
        ) {
    _repository = repository;
  }

  bool validateTaskName(String taskName){
    return taskName.isNotEmpty;
  }

  Future<void> addTask({
    required String title,
  }) async {
    await _repository.addTask(
      Task(
        id: null,
        title: title,
        isCompleted: false,
      ),
    );
  }
}
