import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/tasks_complete_status.dart';
import 'package:todoapp/domain/task_list_sort_helper.dart';
import 'package:todoapp/domain/task_list_summary_helper.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_screen_state.dart';
import 'package:todoapp/ui/components/widgets/task/taskslist/tasks_viewmodel.dart';

import '../../../../../test_utils/fakes/fake_repository.dart';
import '../../../../../test_utils/fakes/fake_share_message_handler.dart';

void main() {
  late TasksViewModel viewModel;
  late FakeRepository fakeRepository;

  setUp(() {
    fakeRepository = FakeRepository(tasks: [], checklists: []);
    viewModel = TasksViewModel(
      repository: fakeRepository,
      taskListSummaryHelper: TaskListSummaryHelperImpl(),
      shareMessageHandler: FakeShareMessageHandler(),
      taskListSortHelper: TaskListSortHelperImpl(),
    );
  });

  test(
    'TasksViewModel -> test initial state',
    () {
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
      List<Task> tasks = [task1];
      await fakeRepository.updateAllTasks(tasks);

      // Act
      await viewModel.updateTasks(null);

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
          tasksCompleteStatus: TasksCompleteStatus.checkAll,
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
      List<Task> tasks = [task1];
      await fakeRepository.updateAllTasks(tasks);
      await viewModel.updateTasks(null);

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
          tasksCompleteStatus: TasksCompleteStatus.uncheckAll,
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
      List<Task> tasks = [task1];
      await fakeRepository.updateAllTasks(tasks);
      await viewModel.updateTasks(null);

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
          tasksCompleteStatus: null,
        ),
      );
    },
  );

  test(
    'TasksViewModel -> test onSort',
    () async {
      const task1 = Task(
        id: 1,
        title: 'Task 1',
        isCompleted: true,
      );
      const task2 = Task(
        id: 2,
        title: 'Task 2',
        isCompleted: false,
      );

      // Arrange
      List<Task> tasks = [task1, task2];
      await fakeRepository.updateAllTasks(tasks);
      await viewModel.updateTasks(null);

      // Act
      viewModel.onSort();

      // Assert
      expect(
        viewModel.state.tasks,
        [task2, task1],
      );
    },
  );
}
