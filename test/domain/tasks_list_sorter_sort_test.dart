import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/task_list_sort_helper.dart';

void main() {
  group('sort tasks', () {
    test(
      'sortByCompletedStatus -> test empty task list',
      () {
        // Arrange
        final helper = TaskListSortHelperImpl();

        // Act
        final result = helper.sortByCompletedStatus([]);

        // Assert
        expect(result, []);
      },
    );

    test(
      'sortByCompletedStatus -> there is a task not completed',
      () {
        // Arrange
        final helper = TaskListSortHelperImpl();
        const taskB = Task(
          id: null,
          title: 'Task B - Completed',
          isCompleted: true,
        );
        const taskA = Task(
          id: null,
          title: 'Task A - Not completed',
          isCompleted: false,
        );
        const taskC = Task(
          id: null,
          title: 'Task C - Completed',
          isCompleted: true,
        );

        // Act
        final result = helper.sortByCompletedStatus(
          [
            taskB,
            taskA,
            taskC,
          ],
        );

        // Assert
        expect(
          result,
          [taskA, taskB, taskC],
        );
      },
    );
  });
}
