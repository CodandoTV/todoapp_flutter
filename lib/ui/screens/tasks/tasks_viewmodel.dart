import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/domain/calculate_task_progress_use_case.dart';
import 'package:todoapp/domain/format_tasklist_use_case.dart';
import 'package:todoapp/domain/should_show_share_use_case.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/util/share_message_handler.dart';

import '../../../data/model/task.dart';

class TasksViewModel extends Cubit<TasksScreenState> {
  late TodoRepository _repository;
  late ShareMessageHandler _shareMessageHandler;
  late FormatTaskListUseCase _formatTaskListUseCase;
  late CalculateTaskProgressUseCase _calculateTaskProgressUseCase;
  late ShouldShowShareUseCase _shouldShowShareUseCase;
  late int? _checklistId;

  TasksViewModel({
    required TodoRepository repository,
    required ShareMessageHandler shareMessageHandler,
    required FormatTaskListUseCase formatTaskListUseCase,
    required CalculateTaskProgressUseCase calculateTaskProgressUseCase,
    required ShouldShowShareUseCase shouldShowShareUseCase,
    int? checklistId,
  }) : super(
          const TasksScreenState(
            tasks: [],
            progress: 0,
            isLoading: true,
            showShareIcon: false,
          ),
        ) {
    _repository = repository;

    _shareMessageHandler = shareMessageHandler;
    _formatTaskListUseCase = formatTaskListUseCase;
    _calculateTaskProgressUseCase = calculateTaskProgressUseCase;
    _shouldShowShareUseCase = shouldShowShareUseCase;

    _checklistId = checklistId;
  }

  void _onLoad() {
    emit(
      state.copyWith(isLoading: true),
    );
  }

  Future<void> updateTasks() async {
    _onLoad();

    var tasks = await _repository.getTasks(_checklistId);
    emit(
      TasksScreenState(
        isLoading: false,
        tasks: tasks,
        showShareIcon: _shouldShowShareUseCase.execute(tasks),
        progress: _calculateTaskProgressUseCase.execute(tasks: tasks),
      ),
    );
  }

  shareTasks({required String checklistName}) async {
    final checklist = _formatTaskListUseCase.execute(
      tasks: state.tasks,
    );

    await _shareMessageHandler.share(
      text: checklist,
      title: checklistName,
    );
  }

  Future<void> onCompleteTask(Task task, bool value) async {
    _onLoad();

    var result = await _repository.updateTask(
      task,
      value,
    );

    if (result == true) {
      List<Task> tasks = List.from(state.tasks);
      var index = state.tasks.indexWhere((item) => item.id == task.id);
      if (index != -1) {
        tasks[index] = tasks[index].copyWith(isCompleted: value);
        emit(
          TasksScreenState(
            progress: _calculateTaskProgressUseCase.execute(tasks: tasks),
            showShareIcon: _shouldShowShareUseCase.execute(tasks),
            isLoading: false,
            tasks: tasks,
          ),
        );
      }
    }
  }

  Future<void> onRemoveTask(Task task) async {
    _onLoad();

    var result = await _repository.deleteTasks([task]);

    if (result) {
      List<Task> tasks = List.from(state.tasks);
      tasks.remove(task);
      emit(
        TasksScreenState(
          progress: _calculateTaskProgressUseCase.execute(tasks: tasks),
          showShareIcon: _shouldShowShareUseCase.execute(tasks),
          isLoading: false,
          tasks: tasks,
        ),
      );
    }
  }

  reorder(int oldIndex, int newIndex) async {
    List<Task> tasks = List.from(state.tasks);
    var task = tasks.removeAt(oldIndex);

    // If moving down the list,
    // adjust newIndex to account for the removed item
    if (newIndex > oldIndex) {
      newIndex--;
    }

    tasks.insert(newIndex, task);

    emit(
      TasksScreenState(
        progress: state.progress,
        isLoading: false,
        showShareIcon: _shouldShowShareUseCase.execute(tasks),
        tasks: tasks,
      ),
    );

    _repository.updateAllTasks(tasks);
  }
}
