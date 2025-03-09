import 'package:flutter/material.dart';
import 'package:todo_app/dependency_factory.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/presentation/home/task_ui_model.dart';
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

  List<TaskUiModel> _taskUiModels = [];

  void _updateTasks() async {
    var tasks = await getTasksUseCase.get();
    var uiModels = tasks
        .map(
          (task) => TaskUiModel(task: task, isChecked: false),
        )
        .toList();

    setState(() {
      _taskUiModels = uiModels;
    });
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
            var taskUiModel = _taskUiModels[index];
            return TaskWidget(
              title: taskUiModel.task.title,
              desc: taskUiModel.task.desc,
              isChecked: taskUiModel.isChecked,
            );
          },
        ));
  }
}
