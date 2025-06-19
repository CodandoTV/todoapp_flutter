import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/ui/screens/home/home_screen_state.dart';

void main() {
  test('HomeScreenState -> test copyWithIsLoading', () {
    var state = const HomeScreenState(
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
