import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/domain/model/task_type.dart';

extension TaskTypeExtension on TaskType {
  IconData toIcon() {
    switch (this) {
      case TaskType.pet:
        return Icons.pets;
      case TaskType.supermarket:
        return Icons.shop;
      case TaskType.chores:
        return Icons.house;
      case TaskType.unknown:
        return Icons.help;
    }
  }
}
