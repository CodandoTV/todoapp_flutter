import 'package:todoapp/ui/widgets/task/task_cell.dart';
import '../../data/model/task.dart';

extension TaskExtension on Task {
  TaskCell toTaskCell(bool isSelected) {
    return TaskCell(
      task: this,
      isSelected: isSelected,
    );
  }
}
