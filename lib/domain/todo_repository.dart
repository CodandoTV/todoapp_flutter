
import 'package:todoapp/domain/model/checklist.dart';
import 'package:todoapp/domain/model/task.dart';

abstract class TodoRepository {
  Future<List<Task>> getTasks(int? checklistId);

  Future<bool> updateTask(Task task, bool isCompletedNewValue);

  Future<bool> updateTasks(List<Task> tasks, bool isCompletedNewValue);

  Future<bool> addTask(Task task, int? checklistId);

  Future<bool> deleteTasks(List<Task> tasks);

  Future<void> updateAllTasks(List<Task> tasks);

  Future<bool> addChecklist(Checklist checklist);

  Future<bool> deleteChecklist(Checklist checklist);

  Future<List<Checklist>> getChecklists();

  Future<bool> updateTaskName({
    required int checklistId,
    required int taskId,
    required String taskTitle,
  });

  Future<bool> share({
    required String text,
    required String title,
  });
}
