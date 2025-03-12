import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/todo_app_route_factory.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  final GetTasksUseCase _getTasksUseCase =
      DependencyFactory.getGetTasksUseCase();
  final UpdateTaskStatusUseCase _updateTaskStatusUseCase =
      DependencyFactory.getUpdateTaskStatusUseCase();

  List<TaskCell> _taskUiModels = [];

  void _updateTasks() async {
    var tasks = await _getTasksUseCase.get();
    var taskCells = tasks.map((element) => element.toTaskCell());
    setState(() {
      _taskUiModels = taskCells.toList();
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
        _taskUiModels.indexWhere((taskCell) => taskCell.task == task);
    if (taskCellToBeDeletedIndex != -1) {
      var taskCellTarget = _taskUiModels[taskCellToBeDeletedIndex];

      setState(() {
        _taskUiModels[taskCellToBeDeletedIndex] = TaskCell(
          icon: taskCellTarget.icon,
          isSelected: !taskCellTarget.isSelected,
          task: taskCellTarget.task,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const CustomAppBar(title: 'Tasks'),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
              context, TodoAppRouteFactory.taskScreenRouteFactory(null));
          if (result) {
            _updateTasks();
          }
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
      body: ListView.builder(
        itemCount: _taskUiModels.length,
        itemBuilder: (context, index) {
          var taskCell = _taskUiModels[index];
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
