import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/task_list_summary_helper.dart';

void main() {
  group('Format tasks list', () {
    test(
      'formatTaskList -> test empty task list',
      () {
        // Arrange
        final formatTaskListMessageUseCase = TaskListSummaryHelperImpl();

        // Act
        final result = formatTaskListMessageUseCase.formatTaskList(
          tasks: [],
        );

        // Assert
        expect(result, '');
      },
    );

    test(
      'formatTaskList -> test only not completed',
      () {
        // Arrange
        final formatTaskListMessageUseCase = TaskListSummaryHelperImpl();

        // Act
        final result = formatTaskListMessageUseCase.formatTaskList(
          tasks: [
            const Task(
              id: null,
              title: 'Task A - Not completed',
              isCompleted: false,
            ),
            const Task(
              id: null,
              title: 'Task B - Not completed',
              isCompleted: false,
            ),
            const Task(
              id: null,
              title: 'Task C - Completed',
              isCompleted: true,
            ),
          ],
        );

        // Assert
        expect(
          result,
          '- Task A - Not completed\n'
          '- Task B - Not completed\n',
        );
      },
    );
  });

  group('should show share button', () {
    test(
      'shouldShowShareButton -> test empty task list',
      () {
        // Arrange
        final helper = TaskListSummaryHelperImpl();

        // Act
        final result = helper.shouldShowShareButton(
          tasks: [],
        );

        // Assert
        expect(result, false);
      },
    );

    test(
      'shouldShowShareButton -> there is a task not completed',
      () {
        // Arrange
        final helper = TaskListSummaryHelperImpl();

        // Act
        final result = helper.shouldShowShareButton(
          tasks: [
            const Task(
              id: null,
              title: 'Task A - Not completed',
              isCompleted: false,
            ),
            const Task(
              id: null,
              title: 'Task B - Completed',
              isCompleted: true,
            ),
            const Task(
              id: null,
              title: 'Task C - Completed',
              isCompleted: true,
            ),
          ],
        );

        // Assert
        expect(
          result,
          true,
        );
      },
    );

    test(
      'shouldShowShareButton -> there is none not completed task',
      () {
        // Arrange
        final helper = TaskListSummaryHelperImpl();

        // Act
        final result = helper.shouldShowShareButton(
          tasks: [
            const Task(
              id: null,
              title: 'Task A -Completed',
              isCompleted: true,
            ),
            const Task(
              id: null,
              title: 'Task B - Completed',
              isCompleted: true,
            ),
          ],
        );

        // Assert
        expect(
          result,
          false,
        );
      },
    );
  });

  group(
    'calculate tasks progress',
    () {
      test(
        'calculateProgress -> test empty task list',
        () {
          // Arrange
          final helper = TaskListSummaryHelperImpl();

          // Act
          final result = helper.calculateProgress(
            tasks: [],
          );

          // Assert
          expect(result, 0.0);
        },
      );

      test(
        'calculateProgress -> test a positive progress',
        () {
          // Arrange
          final helper = TaskListSummaryHelperImpl();

          // Act
          final result = helper.calculateProgress(
            tasks: [
              const Task(
                id: null,
                title: 'Task A - Not completed',
                isCompleted: false,
              ),
              const Task(
                id: null,
                title: 'Task B - Completed',
                isCompleted: true,
              ),
              const Task(
                id: null,
                title: 'Task C - Completed',
                isCompleted: true,
              ),
            ],
          );

          // Assert
          expect(
            result,
            0.6666666666666666,
          );
        },
      );

      test(
        'calculateProgress -> test a bad progress',
        () {
          // Arrange
          final helper = TaskListSummaryHelperImpl();

          // Act
          final result = helper.calculateProgress(
            tasks: [
              const Task(
                id: null,
                title: 'Task A - Not completed',
                isCompleted: false,
              ),
              const Task(
                id: null,
                title: 'Task B - Not Completed',
                isCompleted: false,
              ),
              const Task(
                id: null,
                title: 'Task C - Completed',
                isCompleted: true,
              ),
            ],
          );

          // Assert
          expect(
            result,
            0.3333333333333333,
          );
        },
      );

      test(
        'calculateProgress -> test a great progress',
        () {
          // Arrange
          final helper = TaskListSummaryHelperImpl();

          // Act
          final result = helper.calculateProgress(
            tasks: [
              const Task(
                id: null,
                title: 'Task A - Completed',
                isCompleted: true,
              ),
              const Task(
                id: null,
                title: 'Task B - Completed',
                isCompleted: true,
              ),
              const Task(
                id: null,
                title: 'Task C - Completed',
                isCompleted: true,
              ),
            ],
          );

          // Assert
          expect(
            result,
            1.0,
          );
        },
      );

      test(
        'calculateProgress -> test a horrible progress',
        () {
          // Arrange
          final helper = TaskListSummaryHelperImpl();

          // Act
          final result = helper.calculateProgress(
            tasks: [
              const Task(
                id: null,
                title: 'Task A - Not Completed',
                isCompleted: false,
              ),
              const Task(
                id: null,
                title: 'Task B - Not Completed',
                isCompleted: false,
              ),
              const Task(
                id: null,
                title: 'Task C - Not Completed',
                isCompleted: false,
              ),
            ],
          );

          // Assert
          expect(result, 0.0);
        },
      );
    },
  );
}
