import 'package:injectable/injectable.dart';
import 'package:todoapp/data/database/checklist_dao.dart';
import 'package:todoapp/data/database/task_dao.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/share_message_handler.dart';

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

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TaskDAO _todoDAO;
  final ChecklistDAO _checklistDAO;
  final ShareMessageHandler _shareMessageHandler;

  TodoRepositoryImpl(
    this._todoDAO,
    this._checklistDAO,
    this._shareMessageHandler,
  );

  @override
  Future<List<Task>> getTasks(int? checklistId) async {
    return await _todoDAO.getAll(checklistId);
  }

  @override
  Future<bool> updateTask(Task task, bool isCompletedNewValue) async {
    return await _todoDAO.update(task, isCompletedNewValue);
  }

  @override
  Future<bool> addTask(Task task, int? checklistId) async {
    return await _todoDAO.add(task, checklistId);
  }

  @override
  Future<bool> deleteTasks(List<Task> tasks) async {
    return await _todoDAO.delete(tasks);
  }

  @override
  Future<void> updateAllTasks(List<Task> tasks) async {
    return await _todoDAO.updateAll(tasks);
  }

  @override
  Future<bool> addChecklist(Checklist checklist) async {
    return await _checklistDAO.add(checklist);
  }

  @override
  Future<bool> deleteChecklist(Checklist checklist) async {
    return await _checklistDAO.delete(checklist);
  }

  @override
  Future<List<Checklist>> getChecklists() async {
    return await _checklistDAO.getAll();
  }

  @override
  Future<bool> updateTaskName({
    required int checklistId,
    required int taskId,
    required String taskTitle,
  }) async {
    return await _todoDAO.updateTaskName(
      checklistId: checklistId,
      taskId: taskId,
      taskTitle: taskTitle,
    );
  }

  @override
  Future<bool> updateTasks(List<Task> tasks, bool isCompletedNewValue) async {
    return await _todoDAO.updateTasks(tasks, isCompletedNewValue);
  }

  @override
  Future<bool> share({required String text, required String title}) {
    return _shareMessageHandler.share(text: text, title: title);
  }
}
