import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/todo_repository.dart';

class TaskViewModel {
  late TodoRepository _repository;
  late int? _checklistId;
  Task? _task;

  TaskViewModel(
    TodoRepository repository, {
    required int? checklistId,
    Task? task,
  }) {
    _repository = repository;
    _checklistId = checklistId;
    _task = task;
  }

  bool validateTaskName(String taskName) {
    return taskName.isNotEmpty;
  }

  Future<void> addTaskOrUpdate({
    required String title,
  }) async {
    if (_task == null) {
      await _repository.addTask(
        Task(
          id: null,
          title: title,
          isCompleted: false,
        ),
        _checklistId,
      );
    } else {
      if (_checklistId != null && _task?.id != null) {
        await _repository.updateTaskName(
          checklistId: _checklistId!,
          taskId: _task!.id!,
          taskTitle: title,
        );
      }
    }
  }
}
