import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/domain/tasks_comparator_use_case.dart';

void main() {
  test(
    'areThemEqual -> test empty task list',
    () {
      // Arrange
      final tasksComparatorUseCase = TasksComparatorUseCaseImpl();

      // Act
      final result = tasksComparatorUseCase.areThemEqual(
        oldList: [],
        newList: [],
      );

      // Assert
      expect(result, true);
    },
  );

  test(
    'areThemEqual -> test different sizes',
    () {
      // Arrange
      final tasksComparatorUseCase = TasksComparatorUseCaseImpl();

      // Act
      final result = tasksComparatorUseCase.areThemEqual(
        oldList: [const Task(isCompleted: false, title: 'test', id: 1)],
        newList: [
          const Task(isCompleted: false, title: 'test', id: 1),
          const Task(isCompleted: true, title: 'test2', id: 2)
        ],
      );

      // Assert
      expect(result, false);
    },
  );

  test(
    'areThemEqual -> test same size with different elements',
    () {
      // Arrange
      final tasksComparatorUseCase = TasksComparatorUseCaseImpl();

      // Act
      final result = tasksComparatorUseCase.areThemEqual(
        oldList: [
          const Task(isCompleted: true, title: 'test2', id: 2),
          const Task(isCompleted: false, title: 'test1', id: 1)
        ],
        newList: [
          const Task(isCompleted: false, title: 'test1', id: 1),
          const Task(isCompleted: true, title: 'test2', id: 2),
        ],
      );

      // Assert
      expect(result, false);
    },
  );

  test(
    'areThemEqual -> test same size with equal elements but different values',
    () {
      // Arrange
      final tasksComparatorUseCase = TasksComparatorUseCaseImpl();

      // Act
      final result = tasksComparatorUseCase.areThemEqual(
        oldList: [
          const Task(isCompleted: true, title: 'test1', id: 1),
          const Task(isCompleted: false, title: 'test2', id: 2)
        ],
        newList: [
          const Task(isCompleted: true, title: 'test1', id: 1),
          const Task(isCompleted: true, title: 'test2', id: 2),
        ],
      );

      // Assert
      expect(result, false);
    },
  );

  test(
    'areThemEqual -> test same size with equal elements + equal values',
    () {
      // Arrange
      final tasksComparatorUseCase = TasksComparatorUseCaseImpl();

      // Act
      final result = tasksComparatorUseCase.areThemEqual(
        oldList: [
          const Task(isCompleted: true, title: 'test1', id: 1),
          const Task(isCompleted: false, title: 'test2', id: 2)
        ],
        newList: [
          const Task(isCompleted: true, title: 'test1', id: 1),
          const Task(isCompleted: false, title: 'test2', id: 2),
        ],
      );

      // Assert
      expect(result, true);
    },
  );
}
