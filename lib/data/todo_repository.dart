import 'package:injectable/injectable.dart';
import 'package:todoapp/data/database/checklist_dao.dart';
import 'package:todoapp/data/database/task_dao.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'model/task.dart';

abstract class TodoRepository {
  Future<List<Task>> getTasks();

  Future<bool> updateTask(Task task, bool isCompletedNewValue);

  Future<bool> addTask(Task task);

  Future<bool> deleteTasks(List<Task> tasks);

  Future<void> updateAllTasks(List<Task> tasks);

  Future<bool> addChecklist(Checklist checklist);

  Future<bool> deleteChecklists(List<Checklist> checklists);

  Future<List<Checklist>> getChecklists();
}

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TaskDAO _todoDAO;
  final ChecklistDAO _checklistDAO;

  TodoRepositoryImpl(
    this._todoDAO,
    this._checklistDAO,
  );

  @override
  Future<List<Task>> getTasks() async {
    return _todoDAO.getAll();
  }

  @override
  Future<bool> updateTask(Task task, bool isCompletedNewValue) async {
    return _todoDAO.update(task, isCompletedNewValue);
  }

  @override
  Future<bool> addTask(Task task) async {
    return _todoDAO.add(task);
  }

  @override
  Future<bool> deleteTasks(List<Task> tasks) async {
    return _todoDAO.delete(tasks);
  }

  @override
  Future<void> updateAllTasks(List<Task> tasks) {
    return _todoDAO.updateAll(tasks);
  }

  @override
  Future<bool> addChecklist(Checklist checklist) {
    return _checklistDAO.add(checklist);
  }

  @override
  Future<bool> deleteChecklists(List<Checklist> checklists) {
    return _checklistDAO.delete(checklists);
  }

  @override
  Future<List<Checklist>> getChecklists() {
    return _checklistDAO.getAll();
  }
}
