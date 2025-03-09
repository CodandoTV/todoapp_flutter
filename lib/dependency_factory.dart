import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';

class DependencyFactory {
  static final TodoRepository _repository = TodoRepository();

  static GetTasksUseCase getGetTasksUseCase() {
    return GetTasksUseCase(_repository);
  }
}