import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/task/task_screen_state.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';

import '../../data/fake_repository.dart';

void main() {
  test(
    'TaskViewModel -> test initial state',
    () {
      // Arrange
      final repository = FakeRepository(
        data: [],
      );

      // Act
      final viewModel = TaskViewModel(repository);

      // Assert
      expect(
        viewModel.state,
        const TaskScreenState(
          categoryNames: [],
        ),
      );
    },
  );
}
