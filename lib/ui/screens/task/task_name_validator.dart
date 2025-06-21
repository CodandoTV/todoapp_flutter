
class TaskNameValidator {
  bool validate(String? taskName) {
    return taskName != null && taskName.isNotEmpty;
  }
}