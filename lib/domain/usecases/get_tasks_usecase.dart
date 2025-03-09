import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/domain/model/task.dart';

class GetTasksUseCase{

  final TodoRepository _repository;

  GetTasksUseCase(this._repository);

  Future<List<Task>> get() async {
    return await _repository.getTasks();
  }
}