import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/task.dart';

part 'task_cell.freezed.dart';

@freezed
abstract class TaskCell with _$TaskCell {
  const factory TaskCell({
    required Task task,
    required bool isSelected,
    required IconData icon,
  }) = _TaskCell;
}
