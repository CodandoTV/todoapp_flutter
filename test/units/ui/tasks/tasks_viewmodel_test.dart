import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/calculate_task_progress_use_case.dart';
import 'package:todoapp/domain/format_tasklist_use_case.dart';
import 'package:todoapp/domain/should_show_share_use_case.dart';
import 'package:todoapp/ui/screens/tasks/tasks_screen_state.dart';
import 'package:todoapp/ui/screens/tasks/tasks_viewmodel.dart';

import '../../../fakes/fake_repository.dart';
import '../../../fakes/fake_share_message_handler.dart';

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
      final viewModel = TasksViewModel(
        repository: repository,
        checklistId: null,
        calculateTaskProgressUseCase: CalculateTaskProgressUseCase(),
        formatTaskListUseCase: FormatTaskListUseCase(),
        shareMessageHandler: FakeShareMessageHandler(),
        shouldShowShareUseCase: ShouldShowShareUseCase(),
      );

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          tasks: [],
          showShareIcon: false,
          isLoading: true,
          progress: 0,
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
      final viewModel = TasksViewModel(
        repository: repository,
        checklistId: null,
        calculateTaskProgressUseCase: CalculateTaskProgressUseCase(),
        formatTaskListUseCase: FormatTaskListUseCase(),
        shareMessageHandler: FakeShareMessageHandler(),
        shouldShowShareUseCase: ShouldShowShareUseCase(),
      );

      // Act
      await viewModel.updateTasks();

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          tasks: [
            task1,
          ],
          showShareIcon: true,
          progress: 0,
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
      final viewModel = TasksViewModel(
        repository: repository,
        checklistId: null,
        calculateTaskProgressUseCase: CalculateTaskProgressUseCase(),
        formatTaskListUseCase: FormatTaskListUseCase(),
        shareMessageHandler: FakeShareMessageHandler(),
        shouldShowShareUseCase: ShouldShowShareUseCase(),
      );

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
          showShareIcon: false,
          progress: 1,
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
      final viewModel = TasksViewModel(
        repository: repository,
        checklistId: null,
        shouldShowShareUseCase: ShouldShowShareUseCase(),
        calculateTaskProgressUseCase: CalculateTaskProgressUseCase(),
        formatTaskListUseCase: FormatTaskListUseCase(),
        shareMessageHandler: FakeShareMessageHandler(),
      );

      await viewModel.updateTasks();

      // Act
      await viewModel.onRemoveTask(task1);

      // Assert
      expect(
        viewModel.state,
        const TasksScreenState(
          progress: 0,
          tasks: [],
          showShareIcon: false,
          isLoading: false,
        ),
      );
    },
  );
}
