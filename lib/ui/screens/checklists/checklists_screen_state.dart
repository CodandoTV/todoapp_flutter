import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/checklist.dart';

part 'checklists_screen_state.freezed.dart';

@freezed
class ChecklistsScreenState with _$ChecklistsScreenState {
  final List<Checklist> checklists;
  final bool isLoading;

  const ChecklistsScreenState({
    required this.checklists,
    required this.isLoading,
  });
}
