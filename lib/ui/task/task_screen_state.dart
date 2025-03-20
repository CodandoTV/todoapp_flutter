import 'package:equatable/equatable.dart';

class TaskScreenState extends Equatable {
  final String selectedCategory;
  final List<String> categoryNames;

  const TaskScreenState({
    required this.selectedCategory,
    required this.categoryNames,
  });

  @override
  List<Object?> get props => [selectedCategory, categoryNames];
}
