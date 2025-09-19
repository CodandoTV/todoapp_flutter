import 'package:flutter/material.dart';
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

  IconData getFloatingActionButtonIcon() {
    if (_task == null) {
      return Icons.plus_one;
    } else {
      return Icons.save;
    }
  }

  Future<bool> addTaskOrUpdate({
    required String title,
  }) async {
    var result = false;
    if (_task == null) {
      result = await _repository.addTask(
        Task(
          id: null,
          title: title,
          isCompleted: false,
        ),
        _checklistId,
      );
    } else {
      if (_checklistId != null && _task?.id != null) {
        result = await _repository.updateTaskName(
          checklistId: _checklistId!,
          taskId: _task!.id!,
          taskTitle: title,
        );
      } else {
        result = false;
      }
    }

    return result;
  }
}
