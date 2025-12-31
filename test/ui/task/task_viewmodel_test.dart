import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/checklist.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/ui/screens/task/task_viewmodel.dart';

import '../../test_utils/fakes/fake_repository.dart';

void main() {
  test(
    'TaskViewModel -> add a new task',
    () async {
      // Arrange
      const checklistId = 1;
      final repository = FakeRepository(
        tasks: [],
        checklists: [
          const Checklist(
            id: checklistId,
            title: 'my checklist',
          )
        ],
      );
      final viewModel = TaskViewModel(
        repository,
        checklistId: checklistId,
      );

      // Act
      await viewModel.addTaskOrUpdate(title: 'Teste');

      final result = await repository.getTasks(checklistId);

      // Assert
      expect(
        result.length,
        1,
      );
      expect(
        Icons.plus_one,
        viewModel.getFloatingActionButtonIcon(),
      );
    },
  );

  test(
    'TaskViewModel -> Update an existing task',
    () async {
      // Arrange
      const checklistId = 1;
      const taskId = 2;
      const existingTask = Task(
        id: taskId,
        title: 'Old task title',
        isCompleted: false,
      );
      final repository = FakeRepository(
        tasks: [existingTask],
        checklists: [
          const Checklist(
            id: checklistId,
            title: 'my checklist',
          )
        ],
      );
      final viewModel = TaskViewModel(
        repository,
        task: existingTask,
        checklistId: checklistId,
      );

      // Act
      await viewModel.addTaskOrUpdate(title: 'Updated title');

      final result = await repository.getTasks(checklistId);

      // Assert
      expect(
        result.first.title,
        'Updated title',
      );
      expect(
        Icons.save,
        viewModel.getFloatingActionButtonIcon(),
      );
    },
  );
}
