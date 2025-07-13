import 'package:injectable/injectable.dart';

import '../data/model/task.dart';

@Injectable()
class ShouldShowShareUseCase {
  bool execute(List<Task> tasks) {
    return tasks.any((task) => task.isCompleted == false);
  }
}
