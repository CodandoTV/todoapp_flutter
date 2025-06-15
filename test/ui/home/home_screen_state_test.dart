import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/home/home_screen_state.dart';

void main() {
  test('test copyWithIsLoading', () {
    const state = HomeScreenState(
      taskUiModels: [],
      showTrashIcon: false,
      isLoading: false,
    );

    final result = state.copyWithIsLoading(
      isLoading: true,
    );

    expect(result.isLoading, true);
  });
}
