import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/home/home_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/task/task_cell_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext cubitContext) => HomeScreenCubit(
              cubitContext.read(),
              cubitContext.read(),
              cubitContext.read(),
            ),
        child: _HomeScaffold());
  }
}

class _HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (cubitContext, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
          title: 'tasks',
          showTrashIcon: state.showTrashIcon,
          onDelete: cubitContext.read<HomeScreenCubit>().deleteSelectedTasks,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? result = await context.push('/task');
            if (result == true) {
              cubitContext.read<HomeScreenCubit>().updateTasks();
            }
          },
          child: const Icon(
            Icons.plus_one,
          ),
        ),
        body: ListView.builder(
          itemCount: state.taskUiModels.length,
          itemBuilder: (context, index) {
            var taskCell = state.taskUiModels[index];
            return TaskCellWidget(
              onLongPress: () => {
                cubitContext
                    .read<HomeScreenCubit>()
                    .onTaskLongPressed(taskCell.task)
              },
              onCheckChanged: (value) => {
                cubitContext.read<HomeScreenCubit>().onCheckChanged(
                      taskCell,
                      value ?? false,
                    ),
              },
              cell: taskCell,
            );
          },
        ),
      );
    });
  }
}
