import 'package:flutter/foundation.dart';
import 'package:todo_app/ui/task/task_screen_state.dart';

import '../../data/model/task.dart';
import '../../data/model/task_type.dart';
import '../../data/todo_repository.dart';

class TaskViewModel extends ChangeNotifier {
  late TodoRepository _repository;
  late TaskType _currentTaskCategory;

  var uiState = const TaskScreenState(
    categoryNames: [],
    selectedCategory: "",
  );

  TaskViewModel(TodoRepository repository) : super() {
    _currentTaskCategory = repository.taskCategories().first;
    _repository = repository;

    uiState = TaskScreenState(
      categoryNames: repository.getCategories(),
      selectedCategory: repository.getCategories().first,
    );
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
