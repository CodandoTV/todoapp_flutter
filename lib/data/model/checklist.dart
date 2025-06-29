import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist.freezed.dart';

@freezed
class Checklist with _$Checklist {
  final int? id;
  final String title;

  const Checklist({
    required this.id,
    required this.title,
  });
}
