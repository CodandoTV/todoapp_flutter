import 'package:freezed_annotation/freezed_annotation.dart';

import '../widgets/task/task_cell.dart';

part 'home_screen_state.freezed.dart';

@freezed
abstract class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    required List<TaskCell> taskUiModels,
    required bool showTrashIcon,
  }) = _HomeScreenState;
}
