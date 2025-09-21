import 'package:danger_core/danger_core.dart';

const bigPRThreshold = 300;

void main() {
  // WIP check
  if (danger.github.pr.title.contains('WIP')) {
    warn('PR is considered WIP');
  }

  // Unit tests check
  final allSourceFiles = [
    ...danger.git.modifiedFiles,
    ...danger.git.createdFiles,
  ];

  if (allSourceFiles.any((file) => file.endsWith('_test.dart'))) {
    message('Thanks for updating the unit tests');
  }

  // Big PR check
  final prAdditions = danger.github.pr.additions ?? 0;
  final prDeletions = danger.github.pr.additions ?? 0;
  final isBigPR = (prAdditions + prDeletions) > bigPRThreshold;

  if (isBigPR) {
    warn('Big PR, try to keep changes smaller if you can...');
  }
}
