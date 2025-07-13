import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/calculate_task_progress_use_case.dart';

void main() {
  test(
    'CalculateTaskProgressUseCase -> test empty task list',
    () {
      // Arrange
      final useCase = CalculateTaskProgressUseCase();

      // Act
      final result = useCase.execute(
        tasks: [],
      );

      // Assert
      expect(result, 0.0);
    },
  );

  test(
    'CalculateTaskProgressUseCase -> test a positive progress',
    () {
      // Arrange
      final useCase = CalculateTaskProgressUseCase();

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
    'CalculateTaskProgressUseCase -> test a bad progress',
        () {
      // Arrange
      final useCase = CalculateTaskProgressUseCase();

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
    'CalculateTaskProgressUseCase -> test a great progress',
        () {
      // Arrange
      final useCase = CalculateTaskProgressUseCase();

      // Act
      final result = useCase.execute(
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
    'CalculateTaskProgressUseCase -> test a horrible progress',
        () {
      // Arrange
      final useCase = CalculateTaskProgressUseCase();

      // Act
      final result = useCase.execute(
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
      expect(
        result,
        0.0,
      );
    },
  );
}
