import 'package:injectable/injectable.dart';
import 'package:todoapp/data/model/task.dart';

abstract class ShouldShowShareButtonUseCase {

  bool shouldShowShareButton(List<Task> tasks);
}

@Injectable(as: ShouldShowShareButtonUseCase)
class ShouldShowShareButtonUseCaseImpl extends ShouldShowShareButtonUseCase {
  @override
  bool shouldShowShareButton(List<Task> tasks) {
    return tasks.any((task) => task.isCompleted == false);
  }
}
