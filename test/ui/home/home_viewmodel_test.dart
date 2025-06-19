import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/home/home_screen_state.dart';
import 'package:todoapp/ui/screens/home/home_viewmodel.dart';

import '../../data/fake_repository.dart';

void main() {
  test(
    'test initial state',
    () {
      final repository = FakeRepository();
      final viewModel = HomeViewModel(repository);

      expect(
        viewModel.state,
        const HomeScreenState(
          taskUiModels: [],
          showTrashIcon: false,
          isLoading: true,
        ),
      );
    },
  );

  test(
    'test updateTasks',
    () async {
      final repository = FakeRepository();
      final viewModel = HomeViewModel(repository);

      await viewModel.updateTasks();

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.taskUiModels, isEmpty);
      expect(viewModel.state.showTrashIcon, false);
    },
  );
}
