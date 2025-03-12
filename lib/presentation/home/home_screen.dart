import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/todo_app_route_factory.dart';
import 'package:todo_app/presentation/widgets/task/task_cell.dart';
import 'package:todo_app/presentation/widgets/task_type_extension.dart';
import 'package:todo_app/presentation/widgets/task/task_widget.dart';
import '../widgets/custom_app_bar.dart';

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

  final List<TaskCell> _candidatesToBeDeleted = [];

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

  void _onTaskLongPressed(TaskCell task) {
    if (_candidatesToBeDeleted.contains(task)) {
      _candidatesToBeDeleted.remove(task);
    } else {
      _candidatesToBeDeleted.add(task);
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
          var task = _taskUiModels[index];
          return TaskWidget(
            onLongPress: () => {_onTaskLongPressed(task)},
            onCheckChanged: (value) => {
              _onCheckChanged(
                task,
                value,
              ),
            },
            cell: task,
          );
        },
      ),
    );
  }
}
