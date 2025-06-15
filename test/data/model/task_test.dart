import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/model/task.dart';
import 'package:todoapp/data/model/task_type.dart';

void main() {
  test('test copyWithIsComplete', () {
    const task = Task(
      isCompleted: false,
      title: 'title',
      type: TaskType.chores,
      desc: 'desc',
    );

    final result = task.copyWithIsComplete(
      isCompleted: true,
    );

    expect(result.isCompleted, true);
  });
}
