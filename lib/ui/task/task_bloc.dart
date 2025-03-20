import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/task/task_screen_state.dart';

import '../../data/model/task.dart';
import '../../data/model/task_type.dart';
import '../../data/todo_repository.dart';

class TaskScreenBloc extends Cubit<TaskScreenState> {
  late TodoRepository _repository;
  late TaskType _currentTaskCategory;

  TaskScreenBloc(TodoRepository repository)
      : super(
          TaskScreenState(
            categoryNames: repository.getCategories(),
            selectedCategory: repository.getCategories().first,
          ),
        ) {
    _currentTaskCategory = repository.taskCategories().first;
    _repository = repository;
  }

  void onCategoryChanged(String? categoryName) {
    var category = TaskType.values.firstWhere(
          (task) => task.name == categoryName,
      orElse: () => TaskType.unknown,
    );
    _currentTaskCategory = category;
  }

  Future<void> addTask({
    String? description,
    required String title,
  }) async {
    await _repository.add(
      Task(
        title: title,
        desc: description,
        type: _currentTaskCategory,
        isCompleted: false,
      ),
    );
  }
}
