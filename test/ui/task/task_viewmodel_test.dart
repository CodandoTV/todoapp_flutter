import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
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

  test('TaskViewModel -> test changeCategory and addTask', () async {
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

    await viewModel.onLoad();
    viewModel.onCategoryChanged('Shopping');

    // Act
    await viewModel.addTask(
      title: 'Buy groceries',
      description: 'Milk, Bread, Eggs',
    );

    // Assert
    final result = await repository.getTasks();
    expect(result, [
      const Task(
        id: null,
        title: 'Buy groceries',
        desc: 'Milk, Bread, Eggs',
        isCompleted: false,
        type: 'Shopping',
      )
    ]);
  });
}
