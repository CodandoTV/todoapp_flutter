import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';

void main() {
  test('Task -> test copyWithIsComplete', () {
    const task = Task(
      isCompleted: false,
      title: 'title',
      type: 'chores',
      desc: 'desc',
      id: 1,
    );

    final result = task.copyWithIsComplete(
      isCompleted: true,
    );

    expect(result.isCompleted, true);
  });
}
