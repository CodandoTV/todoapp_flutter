import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/format_task_list_message_use_case.dart';

void main() {
  test(
    'formatTaskList -> test empty task list',
    () {
      // Arrange
      final formatTaskListMessageUseCase = FormatTaskListMessageUseCaseImpl();

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
      final formatTaskListMessageUseCase = FormatTaskListMessageUseCaseImpl();

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
}
