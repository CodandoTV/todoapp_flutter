import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_screen_state.freezed.dart';

@freezed
abstract class TaskScreenState with _$TaskScreenState {
  const factory TaskScreenState({
    required String selectedCategory,
    required List<String> categoryNames,
  }) = _TaskScreenState;
}
