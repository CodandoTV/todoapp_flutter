import '../../data/todo_repository.dart';
import '../model/task.dart';

class AddNewTaskUseCase {
  final TodoRepository _repository;

  AddNewTaskUseCase(this._repository);

  Future<bool> add(Task task) async {
    return await _repository.add(task);
  }
}
