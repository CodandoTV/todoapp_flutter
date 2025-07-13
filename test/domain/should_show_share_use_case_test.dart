import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/should_show_share_use_case.dart';

void main() {
  test(
    'ShouldShowShareUseCase -> test empty task list',
    () {
      // Arrange
      final useCase = ShouldShowShareUseCase();

      // Act
      final result = useCase.execute([]);

      // Assert
      expect(result, false);
    },
  );

  test(
    'ShouldShowShareUseCase -> there is a task not completed',
    () {
      // Arrange
      final useCase = ShouldShowShareUseCase();

      // Act
      final result = useCase.execute(
        [
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
    'ShouldShowShareUseCase -> there is none not completed task',
    () {
      // Arrange
      final useCase = ShouldShowShareUseCase();

      // Act
      final result = useCase.execute(
        [
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
}
