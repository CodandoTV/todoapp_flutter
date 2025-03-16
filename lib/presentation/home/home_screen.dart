import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/usecases/delete_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/widgets/task/task_cell.dart';
import 'package:todo_app/presentation/widgets/task_type_extension.dart';
import '../../domain/model/task.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/task/task_cell_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class HomeScreenUIState {
  List<TaskCell> taskUiModels = [];
  var showTrashIcon = false;
}

class _HomeScreenState extends State<HomeScreen> {
  late GetTasksUseCase _getTasksUseCase;
  late UpdateTaskStatusUseCase _updateTaskStatusUseCase;
  late DeleteTasksUseCase _deleteTasksUseCase;

  final HomeScreenUIState _uiState = HomeScreenUIState()
    ..showTrashIcon = false
    ..taskUiModels = [];

  List<Task> _taskToBedeleted = [];

  @override
  void initState() {
    super.initState();

    _getTasksUseCase = context.read();
    _updateTaskStatusUseCase = context.read();
    _deleteTasksUseCase = context.read();

    _updateTasks();
  }

  void _deleteSelectedTasks() async {
    _deleteTasksUseCase.delete(_taskToBedeleted);
    _taskToBedeleted = [];

    _updateTasks();
  }

  void _updateTasks() async {
    var tasks = await _getTasksUseCase.get();
    var taskCells = tasks.map((element) => element.toTaskCell());
    setState(() {
      _uiState.taskUiModels = taskCells.toList();
      _uiState.showTrashIcon = false;

      _taskToBedeleted = [];
    });
  }

  void _onCheckChanged(TaskCell taskCell, bool? value) async {
    var result = await _updateTaskStatusUseCase.update(
      taskCell.task,
      value ?? false,
    );
    if (result) {
      _updateTasks();
    }
  }

  void _onTaskLongPressed(Task task) {
    var taskCellToBeDeletedIndex =
        _uiState.taskUiModels.indexWhere((taskCell) => taskCell.task == task);
    if (taskCellToBeDeletedIndex != -1) {
      var taskCellTarget = _uiState.taskUiModels[taskCellToBeDeletedIndex];

      var newSelectionValue = !taskCellTarget.isSelected;

      if (newSelectionValue) {
        _taskToBedeleted.add(task);
      } else {
        _taskToBedeleted.remove(task);
      }

      setState(() {
        _uiState.taskUiModels[taskCellToBeDeletedIndex] = TaskCell(
          icon: taskCellTarget.icon,
          isSelected: newSelectionValue,
          task: taskCellTarget.task,
        );

        _uiState.showTrashIcon = _taskToBedeleted.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Tasks',
        showTrashIcon: _uiState.showTrashIcon,
        onDelete: () => {_deleteSelectedTasks()},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await context.push('/task');
          if (result == true) {
            _updateTasks();
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: ListView.builder(
        itemCount: _uiState.taskUiModels.length,
        itemBuilder: (context, index) {
          var taskCell = _uiState.taskUiModels[index];
          return TaskCellWidget(
            onLongPress: () => {_onTaskLongPressed(taskCell.task)},
            onCheckChanged: (value) => {
              _onCheckChanged(
                taskCell,
                value,
              ),
            },
            cell: taskCell,
          );
        },
      ),
    );
  }
}
