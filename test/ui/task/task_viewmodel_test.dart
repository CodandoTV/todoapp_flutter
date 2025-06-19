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
        categories: [],
      );

      // Act
      final viewModel = TaskViewModel(repository);

      // Assert
      expect(
        viewModel.state,
        const TaskScreenState(
          selectedCategory: '',
          categoryNames: [],
        ),
      );
    },
  );

  test(
    'TaskViewModel -> test load',
    () async {
      // Arrange
      final repository = FakeRepository(
        data: [],
        categories: [
          'Work',
          'Personal',
          'Shopping',
        ],
      );
      final viewModel = TaskViewModel(repository);

      // Act
      await viewModel.onLoad();

      // Assert
      expect(
        viewModel.state,
        const TaskScreenState(
          selectedCategory: 'Work',
          categoryNames: [
            'Work',
            'Personal',
            'Shopping',
          ],
        ),
      );
    },
  );
}
