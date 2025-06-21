import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/task/task_name_validator.dart';

void main() {
  test(
    'TaskNameValidator -> give a null task name when validate then returns false',
        () {
      // Arrange
      TaskNameValidator taskNameValidator = TaskNameValidator();

      // Act
      final result = taskNameValidator.validate(null);

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskNameValidator -> give an empty task name when validate then returns false',
        () {
      // Arrange
      TaskNameValidator taskNameValidator = TaskNameValidator();

      // Act
      final result = taskNameValidator.validate('');

      // Assert
      expect(result, false);
    },
  );

  test(
    'TaskNameValidator -> give a valid task name when validate then returns false',
        () {
      // Arrange
      TaskNameValidator taskNameValidator = TaskNameValidator();

      // Act
      final result = taskNameValidator.validate('Buy guinea pig food');

      // Assert
      expect(result, true);
    },
  );
}