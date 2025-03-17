// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:todo_app/data/model/task.dart';
import 'package:todo_app/data/model/task_type.dart';
import 'package:todo_app/data/todo_in_memory_data_source.dart';

void main() {
  test('test update task', () async {
    final todoInMemory = TodoInMemoryDataSource([
      Task(
        title: 'Buy guinea pig food',
        type: TaskType.pet,
        desc: 'Should buy megazoo',
        isCompleted: false,
      )
    ]);
    var tasks = await todoInMemory.getTasks();
    var firstTask = tasks.first;

    todoInMemory.update(firstTask, true);

    final result = await todoInMemory.getTasks();
    expect(result.first.isCompleted, true);
  });

  test('test getTasks', () async {
    final expectedTasks = [
      Task(
        title: 'Buy guinea pig food',
        type: TaskType.pet,
        desc: 'Should buy megazoo',
        isCompleted: false,
      ),
    ];
    final todoInMemory = TodoInMemoryDataSource(expectedTasks);
    var tasks = await todoInMemory.getTasks();

    expect(expectedTasks, tasks);
  });

  test('test addTasks', () async {
    final newTask = Task(
      title: 'title',
      desc: 'desc',
      type: TaskType.chores,
      isCompleted: false,
    );
    final todoInMemory = TodoInMemoryDataSource([
      Task(
        title: 'Buy guinea pig food',
        type: TaskType.pet,
        desc: 'Should buy megazoo',
        isCompleted: false,
      ),
    ]);

    await todoInMemory.add(newTask);

    final tasks = await todoInMemory.getTasks();

    expect(newTask, tasks.last);
  });

  test('test delete task', () async {
    final targetTask = Task(
      title: 'Buy guinea pig food',
      type: TaskType.pet,
      desc: 'Should buy megazoo',
      isCompleted: false,
    );
    final todoInMemory = TodoInMemoryDataSource([targetTask]);

    await todoInMemory.delete([targetTask]);

    final tasks = await todoInMemory.getTasks();

    expect(true, tasks.isEmpty);
  });
}
