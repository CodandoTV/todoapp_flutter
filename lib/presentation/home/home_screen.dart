import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/model/task.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_status_usecase.dart';
import 'package:todo_app/presentation/todo_app_navigator.dart';
import 'package:todo_app/presentation/widgets/task_widget.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetTasksUseCase getTasksUseCase = DependencyFactory.getGetTasksUseCase();
  UpdateTaskStatusUseCase updateTaskStatusUseCase =
      DependencyFactory.getUpdateTaskStatusUseCase();

  List<Task> _taskUiModels = [];

  void _updateTasks() async {
    var tasks = await getTasksUseCase.get();
    setState(() {
      _taskUiModels = tasks;
    });
  }

  void _onCheckChanged(Task task, bool? value) async {
    var result = await updateTaskStatusUseCase.update(task, value ?? false);
    if (result) {
      _updateTasks();
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
          onPressed: () {
            TodoAppNavigator.pushTaskScreen(
              context: context,
            );
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
              title: task.title,
              desc: task.desc,
              isChecked: task.isCompleted,
              onCheckChanged: (value) => {
                _onCheckChanged(
                  task,
                  value,
                ),
              },
            );
          },
        ));
  }
}
