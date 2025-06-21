
class TaskScreenValidator {
  bool validateTaskName(String? taskName) {
    return taskName != null && taskName.isNotEmpty;
  }

  bool validateTaskType(String? taskType) {
    return taskType != null && taskType.isNotEmpty;
  }
}