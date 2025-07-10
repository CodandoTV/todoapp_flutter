import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/format_tasklist_use_case.dart';

void main() {
  test(
    'FormatTasklistUseCase -> test empty task list',
    () {
      // Arrange
      final useCase = FormatTaskListUseCase();

      // Act
      final result = useCase.execute(
        tasks: [],
        formatMode: FormatMode.allTasks,
      );

      // Assert
      expect(result, '');
    },
  );

  test(
    'FormatTasklistUseCase -> test only not completed',
    () {
      // Arrange
      final useCase = FormatTaskListUseCase();

      // Act
      final result = useCase.execute(
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
        formatMode: FormatMode.onlyNotCompleted,
      );

      // Assert
      expect(
        result,
        '- Task A - Not completed\n'
        '- Task B - Not completed\n',
      );
    },
  );

  test(
    'FormatTasklistUseCase -> test all tasks',
    () {
      // Arrange
      final useCase = FormatTaskListUseCase();

      // Act
      final result = useCase.execute(
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
        formatMode: FormatMode.allTasks,
      );

      // Assert
      expect(
        result,
        '- Task A - Not completed\n'
        '- Task B - Not completed\n'
        '- Task C - Completed\n',
      );
    },
  );
}
