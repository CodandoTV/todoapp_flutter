import 'package:todo_app/domain/model/task_type.dart';

class GetCategoriesUseCase {
  List<String> get() {
    return TaskType.values.map((element) => element.name).toList();
  }
}
