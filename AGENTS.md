# AGENTS.md

## Project

TodoApp — sample Flutter app (Android/iOS/macOS) for checklists + tasks,
persisted with sqflite. flutter_bloc (Cubit), get_it + injectable, auto_route,
freezed, EN/PT localization. Dart package name is `todoapp`.

## Commands

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs  # freezed/injectable/auto_route
flutter gen-l10n                                          # lib/ui/l10n/app_localizations*.dart
flutter test
flutter test test/domain/tasks_list_sort_test.dart        # one file
flutter test --plain-name 'TasksViewModel'                # one test
dart analyze
dart run eagle_eye:main                                   # architecture check
flutter run -d <device>
```

Flutter is pinned to 3.38.3 (`.github/actions/setup-flutter/action.yml`).
Re-run codegen after touching `@freezed` classes, `@Injectable`/DI, `@RoutePage`
/router config, or `.arb` files — tests and `dart analyze` fail without the
generated files. Generated outputs (`*.freezed.dart`, `*.config.dart`,
`*.gr.dart`, `lib/ui/l10n/app_localizations*.dart`) are gitignored; never
hand-edit or commit them.

## Layout

```
lib/
  domain/  model/ (freezed) + repository interface + sort/summary helpers
  data/    database/ DAOs, todo_repository_impl.dart, share_message_handler.dart
  ui/      screens/<feature>/ (screen + viewmodel + screen_state),
           components/widgets, l10n/
  util/    di/ (injectable), navigation_provider.dart
```

`main.dart` only runs `TodoApp`; DI and the router initialize in
`lib/ui/screens/startup/startup_screen.dart` via
`GetItStartupHandlerWrapper.init()`.

## Architecture constraints (eagle_eye, enforced in CI)

Config: `eagle_eye_config.json`. It only checks internal
(`package:todoapp/...`) imports; external packages are always allowed.

- `*viewmodel.dart` may only import `package:todoapp/domain/*` and
  `*_screen_state.dart`. Keep UI/widgets out of viewmodels.
- `lib/util/*_provider.dart` and `lib/util/*_handler.dart` may import no other
  `package:todoapp/*` file.
- The `*/data/model/*` rule matches nothing today (models live in
  `lib/domain/model/`).

## Conventions

Lints are promoted to `error` in `analysis_options.yaml`, so violations fail
`dart analyze`. Highest impact: single quotes, `package:` imports only (no
relative), directive ordering (`dart:` → `package:` → project), 80-char lines,
explicit return types, `const` constructors, braces on all control flow,
snake_case files. `avoid_print` is disabled.

Naming: interfaces plain (`TodoRepository`), implementations `...Impl`. Cubits
are `@Injectable()`; other impls `@Injectable(as: Interface)`.

## Testing

- Codegen must complete before tests (localizations are required).
- Mirror `lib/` under `test/`; domain logic is plain Dart
  (Arrange/Act/Assert, real implementations).
- Cubit tests use the in-memory `FakeRepository` from
  `test/test_utils/fakes/`. No mocking framework — fakes are hand-written
  (`FakeRepository`, `FakeNavigatorProvider`, `FakeCallbacks`, `FakeStates`).
- Widget tests wrap with `WidgetsUtil.buildMaterialAppWidgetTest(tester: tester,
  child: ...)`; it forces the `en` locale because tests assert English strings.

## CI / release

PRs to `main` (`.github/workflows/pr.yml`), all must pass:
`flutter gen-l10n` → `dart run eagle_eye:main` → `flutter test` →
`dart analyze` → `flutter build apk --debug`.

Any tag triggers `.github/workflows/release_flutter_app.yaml` (APK to Firebase
App Distribution, macOS zip to a GitHub Release).

Commits follow conventional commits; the repo-local `feature-branch-pr` skill
(`.opencode/skills/feature-branch-pr/SKILL.md`) creates `feature/<name>`
branches and PRs.
