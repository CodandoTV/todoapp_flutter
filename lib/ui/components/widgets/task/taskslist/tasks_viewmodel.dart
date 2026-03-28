import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';
import 'package:todoapp/data/todo_repository.dart';
import 'package:todoapp/domain/task_list_summary_helper.dart';
import 'package:todoapp/domain/tasks_comparator_use_case.dart';
import 'package:todoapp/domain/tasks_sorter_use_case.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_screen_state.dart';
import 'package:todoapp/util/share_message_handler.dart';

class TasksViewModel extends Cubit<TasksScreenState> {
  late TodoRepository _repository;
  late ShareMessageHandler _shareMessageHandler;
  late TaskListSummaryHelper _taskListSummaryHelper;

  TasksSorterUseCase tasksSorterUseCase;
  TasksComparatorUseCase tasksComparatorUseCase;

  TasksViewModel({
    required TodoRepository repository,
    required ShareMessageHandler shareMessageHandler,
    required TaskListSummaryHelper taskListSummaryHelper,
    required this.tasksSorterUseCase,
    required this.tasksComparatorUseCase,
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
    _taskListSummaryHelper = taskListSummaryHelper;
  }

  void _onLoad() {
    emit(
      state.copyWith(isLoading: true),
    );
  }

  Future<void> onCompleteButtonAction(int? checklistId) async {
    TasksCompleteStatus status = _taskListSummaryHelper.checkStatus(
      tasks: state.tasks,
    );

    await _repository.updateTasks(
      state.tasks,
      status == TasksCompleteStatus.checkAll,
    );

    await updateTasks(checklistId);
  }

  Future<void> updateTasks(int? checklistId) async {
    _onLoad();

    var tasks = await _repository.getTasks(checklistId);

    TasksCompleteStatus status = _taskListSummaryHelper.checkStatus(
      tasks: tasks,
    );

    emit(
      state.copyWith(
        isLoading: false,
        tasks: tasks,
        tasksCompleteStatus: status,
        showShareIcon: _taskListSummaryHelper.shouldShowShareButton(
          tasks: tasks,
        ),
        progress: _taskListSummaryHelper.calculateProgress(tasks: tasks),
      ),
    );
  }

  Future<void> shareTasks({required String checklistName}) async {
    final checklist = _taskListSummaryHelper.formatTaskList(
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
          state.copyWith(
            progress: _taskListSummaryHelper.calculateProgress(tasks: tasks),
            showShareIcon: _taskListSummaryHelper.shouldShowShareButton(
              tasks: tasks,
            ),
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
        state.copyWith(
            progress: _taskListSummaryHelper.calculateProgress(tasks: tasks),
            showShareIcon: _taskListSummaryHelper.shouldShowShareButton(
              tasks: tasks,
            ),
            isLoading: false,
            tasks: tasks),
      );
    }
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    List<Task> tasks = List.from(state.tasks);
    var task = tasks.removeAt(oldIndex);

    // If moving down the list,
    // adjust newIndex to account for the removed item
    if (newIndex > oldIndex) {
      newIndex--;
    }

    tasks.insert(newIndex, task);

    emit(
      state.copyWith(
        isLoading: false,
        showShareIcon: _taskListSummaryHelper.shouldShowShareButton(
          tasks: tasks,
        ),
        tasks: tasks,
      ),
    );

    _repository.updateAllTasks(tasks);
  }

  void onSort() {
    List<Task> tasksToBeSorted = tasksSorterUseCase.sortByCompletedStatus(
      state.tasks,
    );

    bool wasSortedPerformed = tasksComparatorUseCase.areThemEqual(
      oldList: state.tasks,
      newList: tasksToBeSorted,
    );

    debugPrint('Was Sorted performed $wasSortedPerformed');

    emit(
      state.copyWith(
        tasks: tasksToBeSorted,
      ),
    );

    _repository.updateAllTasks(tasksToBeSorted);
  }
}
