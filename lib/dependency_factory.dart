import 'package:todo_app/data/todo_in_memory_data_source.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/domain/usecases/add_new_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';

import 'domain/usecases/get_categories_usecase.dart';

class DependencyFactory {
  static final TodoInMemoryDataSource _todoInMemoryDataSource =
      TodoInMemoryDataSource();

  static final TodoRepository _repository =
      TodoRepository(_todoInMemoryDataSource);

  static GetTasksUseCase getGetTasksUseCase() {
    return GetTasksUseCase(_repository);
  }

  static UpdateTaskStatusUseCase getUpdateTaskStatusUseCase() {
    return UpdateTaskStatusUseCase(_repository);
  }

  static AddNewTaskUseCase getAddNewTaskUseCase() {
    return AddNewTaskUseCase(_repository);
  }

  static GetCategoriesUseCase getGetCategoriesUseCase() {
    return GetCategoriesUseCase();
  }

  static DeleteTasksUseCase getDeleteTasksUseCase() {
    return DeleteTasksUseCase(_repository);
  }
}
