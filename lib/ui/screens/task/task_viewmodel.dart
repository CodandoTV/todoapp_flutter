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
            selectedCategory: '',
            categoryNames: [],
          ),
        ) {
    _repository = repository;

    _onLoad();
  }

  _onLoad() async {
    final categories = await _repository.taskCategories();
    _currentTaskCategory = categories.first;

    emit(
      TaskScreenState(
        categoryNames: categories,
        selectedCategory: _currentTaskCategory,
      ),
    );
  }

  void onCategoryChanged(String? categoryName) {
    _currentTaskCategory = categoryName ?? '';
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
