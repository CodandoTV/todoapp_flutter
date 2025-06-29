import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/home/home_screen_state.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';

import '../../data/fake_repository.dart';

void main() {
  test(
    'HomeViewModel -> test initial state',
    () {
      // Arrange
      final repository = FakeRepository(
        tasks: [],
        checklists: [],
      );

      // Act
      final viewModel = HomeViewModel(repository);

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          tasks: [],
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
        isCompleted: false,
      );
      final repository = FakeRepository(
        tasks: [task1],
        checklists: [],
      );
      final viewModel = HomeViewModel(repository);

      // Act
      await viewModel.updateTasks();

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          tasks: [
              task1,
          ],
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
        isCompleted: false,
      );
      // Arrange
      final repository = FakeRepository(
        tasks: [task1],
        checklists: [],
      );
      final viewModel = HomeViewModel(repository);

      await viewModel.updateTasks();

      // Act
      await viewModel.onCompleteTask(
          task1,
          true,
      );

      // Assert
      const expectedTask = Task(
        id: 1,
        title: 'Task 1',
        isCompleted: true,
      );
      expect(
        viewModel.state,
        const HomeScreenState(
          tasks: [
             expectedTask,
          ],
          isLoading: false,
        ),
      );
    },
  );

  test(
    'HomeViewModel -> test onRemoveTask',
    () async {
      const task1 = Task(
        id: 1,
        title: 'Task 1',
        isCompleted: false,
      );
      // Arrange
      final repository = FakeRepository(
        tasks: [task1],
        checklists: [],
      );
      final viewModel = HomeViewModel(repository);

      await viewModel.updateTasks();

      // Act
      await viewModel.onRemoveTask(task1);

      // Assert
      expect(
        viewModel.state,
        const HomeScreenState(
          tasks: [],
          isLoading: false,
        ),
      );
    },
  );
}
