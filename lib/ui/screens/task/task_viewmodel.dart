import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/ui/screens/task/task_screen_state.dart';

import '../../../data/model/task.dart';
import '../../../data/todo_repository.dart';

class TaskViewModel extends Cubit<TaskScreenState> {
  late TodoRepository _repository;
  String _currentTaskCategory = '';

  TaskViewModel(TodoRepository repository)
      : super(
          const TaskScreenState(
            categoryNames: [],
          ),
        ) {
    _repository = repository;
  }

  Future<void> onLoad() async {
    final categories = await _repository.taskCategories();

    emit(
      TaskScreenState(categoryNames: categories),
    );
  }

  void onCategoryChanged(String? categoryName) {
    _currentTaskCategory = categoryName ?? '';
  }

  bool validateTaskName(String taskName){
    return taskName.isNotEmpty;
  }

  Future<void> addTask({
    String? description,
    required String title,
  }) async {
    await _repository.add(
      Task(
        id: null,
        title: title,
        desc: description,
        type: _currentTaskCategory,
        isCompleted: false,
      ),
    );
  }
}
