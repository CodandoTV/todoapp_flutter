import '../../data/todo_repository.dart';
import '../model/task.dart';

class DeleteTasksUseCase {
  final TodoRepository _repository;

  DeleteTasksUseCase(this._repository);

  void delete(List<Task> tasks) async {
    _repository.delete(tasks);
  }
}