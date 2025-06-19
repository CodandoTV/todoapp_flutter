import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/home/home_screen_state.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';
import 'package:todoapp/ui/widgets/task/task_cell.dart';

import '../../data/fake_repository.dart';

void main() {
  test(
    'HomeViewModel -> test initial state',
    () {
      // Arrange
      final repository = FakeRepository(
        data: [],
        categories: [],
      );

      // Act
      final viewModel = HomeViewModel(repository);

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          taskUiModels: [],
          showTrashIcon: false,
          isLoading: true,
        ),
      );
    },
  );

  test(
    'HomeViewModel -> test updateTasks',
    () async {
      // Arrange
      const task1 = Task(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        isCompleted: false,
        type: 'Pet',
      );
      final repository = FakeRepository(
        data: [task1],
        categories: [],
      );
      final viewModel = HomeViewModel(repository);

      // Act
      await viewModel.updateTasks();

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          taskUiModels: [
            TaskCell(
              task: task1,
              isSelected: false,
              icon: Icons.pets,
            )
          ],
          showTrashIcon: false,
          isLoading: false,
        ),
      );
    },
  );

  test(
    'HomeViewModel -> test onCompleteTask',
    () async {
      const task1 = Task(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        isCompleted: false,
        type: 'Pet',
      );
      // Arrange
      final repository = FakeRepository(
        data: [task1],
        categories: [],
      );
      final viewModel = HomeViewModel(repository);

      await viewModel.updateTasks();

      // Act
      await viewModel.onCompleteTask(
        const TaskCell(
          task: task1,
          isSelected: false,
          icon: Icons.pets,
        ),
        true,
      );

      // Assert
      const expectedTask = Task(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        isCompleted: true,
        type: 'Pet',
      );
      expect(
        viewModel.state,
        const HomeScreenState(
          taskUiModels: [
            TaskCell(
              task: expectedTask,
              isSelected: false,
              icon: Icons.pets,
            )
          ],
          showTrashIcon: false,
          isLoading: false,
        ),
      );
    },
  );

  test(
    'HomeViewModel -> test deleteSelectedTasks',
    () async {
      const task1 = Task(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        isCompleted: false,
        type: 'Pet',
      );
      // Arrange
      final repository = FakeRepository(
        data: [task1],
        categories: [],
      );
      final viewModel = HomeViewModel(repository);

      await viewModel.updateTasks();

      viewModel.onRemoveTask(task1);

      // Act
      await viewModel.deleteSelectedTasks();

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          taskUiModels: [],
          showTrashIcon: false,
          isLoading: false,
        ),
      );
    },
  );
}
