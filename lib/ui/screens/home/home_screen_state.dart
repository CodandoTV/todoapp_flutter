import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/data/model/checklist.dart';

part 'home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  final List<Checklist> checklists;
  final bool isLoading;

  const HomeScreenState({
    required this.checklists,
    required this.isLoading,
  });
}
