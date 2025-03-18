import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/ui/home/home_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/task/task_cell_widget.dart';
import 'home_screen_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext cubitContext) {
        final bloc = HomeScreenBloc(
          cubitContext.read(),
        );
        bloc.updateTasks();
        return bloc;
      },
      child: _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (cubitContext, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
          title: 'Tasks',
          showTrashIcon: state.showTrashIcon,
          onDelete: cubitContext.read<HomeScreenBloc>().deleteSelectedTasks,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? result = await context.push('/task');
            if (result == true) {
              cubitContext.read<HomeScreenBloc>().updateTasks();
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
                cubitContext.read<HomeScreenBloc>().onRemoveTask(taskCell.task)
              },
              onCheckChanged: (value) => {
                cubitContext.read<HomeScreenBloc>().onCompleteTask(
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
