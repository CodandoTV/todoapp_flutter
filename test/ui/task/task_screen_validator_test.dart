import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/task/task_screen_validator.dart';

void main() {
  test(
    'TaskScreenValidator -> give a null task name when validate then returns false',
    () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskName(null);

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskScreenValidator -> give an empty task name when validate then returns false',
    () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskName('');

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskScreenValidator -> give a valid task name when validate then returns false',
    () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskName('Buy guinea pig food');

      // Assert
      expect(result, true);
    },
  );

  test(
    'TaskScreenValidator -> give a null task type when validate then returns false',
        () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskType(null);

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskScreenValidator -> give an empty task type when validate then returns false',
        () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskType('');

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskScreenValidator -> give a valid task type when validate then returns false',
        () {
      // Arrange
      TaskScreenValidator taskNameValidator = TaskScreenValidator();

      // Act
      final result = taskNameValidator.validateTaskType('Pets');

      // Assert
      expect(result, true);
    },
  );
}
