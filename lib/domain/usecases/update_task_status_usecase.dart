import 'package:todo_app/domain/model/task.dart';

import '../../data/todo_repository.dart';

class UpdateTaskStatusUseCase {
  final TodoRepository _repository;

  UpdateTaskStatusUseCase(this._repository);

  Future<bool> update(Task task, bool isCompleted) async {
    return await _repository.update(task, isCompleted);
  }
}