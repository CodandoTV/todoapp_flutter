import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_viewmodel.dart';

import '../../data/fake_repository.dart';

void main() {
  test(
    'TasksViewModel -> test initial state',
    () {
      // Arrange
      final repository = FakeRepository(
        tasks: [],
        checklists: [],
      );

      // Act
      final viewModel = TasksViewModel(repository);

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          tasks: [],
          isLoading: true,
        ),
      );
    },
  );

  test(
    'TasksViewModel -> test updateTasks',
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
      final viewModel = TasksViewModel(repository);

      // Act
      await viewModel.updateTasks();

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          tasks: [
              task1,
          ],
          isLoading: false,
        ),
      );
    },
  );

  test(
    'TasksViewModel -> test onCompleteTask',
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
      final viewModel = TasksViewModel(repository);

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
        const TasksScreenState(
          tasks: [
             expectedTask,
          ],
          isLoading: false,
        ),
      );
    },
  );

  test(
    'TasksViewModel -> test onRemoveTask',
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
      final viewModel = TasksViewModel(repository);

      await viewModel.updateTasks();

      // Act
      await viewModel.onRemoveTask(task1);

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          tasks: [],
          isLoading: false,
        ),
      );
    },
  );
}
