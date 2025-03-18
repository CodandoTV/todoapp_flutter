import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/model/task.dart';
import 'package:todo_app/data/model/task_type.dart';
import 'package:todo_app/data/todo_in_memory_data_source.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/ui/home/home_bloc.dart';
import 'package:todo_app/ui/home/home_screen_state.dart';
import 'package:todo_app/ui/widgets/task/task_cell.dart';

void main() {
  HomeScreenBloc build(List<Task> tasks) {
    return HomeScreenBloc(TodoRepository(TodoInMemoryDataSource(tasks)));
  }

  blocTest(
    'test updateTasks',
    build: () => build(
      [
        const Task(
          title: 'title',
          desc: 'desc',
          type: TaskType.chores,
          isCompleted: false,
        )
      ],
    ),
    act: (bloc) => bloc.updateTasks(),
    expect: () => {
      const HomeScreenState(
        taskUiModels: [
          TaskCell(
            task: Task(
              title: 'title',
              desc: 'desc',
              type: TaskType.chores,
              isCompleted: false,
            ),
            isSelected: false,
            icon: Icons.house,
          )
        ],
        showTrashIcon: false,
      )
    },
  );
}
