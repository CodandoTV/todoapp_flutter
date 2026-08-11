# AGENTS.md

`[opencode] AGENTS.md loaded`

## Project Overview

TodoApp is a sample Flutter project built as a testing playground. It manages
checklists and tasks using sqflite for local persistence. Targets Android, iOS,
and macOS. Uses flutter_bloc (Cubit) for state management, get_it + injectable
for DI, auto_route for navigation, freezed for immutable models, and supports
English/Portuguese localization.

## Dev Environment Setup

1. Install Flutter 3.38.x (see `.github/actions/setup-flutter/action.yml` for
   the pinned version)
2. `flutter pub get`
3. `dart run build_runner build --delete-conflicting-outputs`
4. `flutter gen-l10n`

Steps 3 and 4 must be re-run after any changes to annotated classes
(`*.freezed.dart`, router config, injectable config) or `.arb` localization
files.

## Project Architecture

### Layer-first layout

```
lib/
  data/         — models (freezed), DAOs (sqflite), repository, share handler
  domain/       — sort & summary helpers
  ui/           — screens (features), shared components, widgets, l10n
  util/         — DI (get_it + injectable), navigation provider
```

### Key patterns

- **State management:** flutter_bloc (Cubit) with freezed immutable states.
  Cubits are `@Injectable()` and used via `BlocProvider`/`BlocBuilder`.
- **DI:** get_it + injectable with code-gen. Initialized at startup via
  `GetItStartupHandlerWrapper`.
- **Navigation:** auto_route (generated router). Abstracted behind
  `NavigatorProvider` interface for testability.
- **Data:** Abstract repository → Impl → DAO pattern. The Abstract + Impl
  convention is also used for `NavigatorProvider`, `ShareMessageHandler`, and
  `TaskListSortHelper`.

### Code generation

Generated files (`*.freezed.dart`, `*.config.dart`, `*.gr.dart`,
`app_localizations*.dart`) are gitignored. Generated on demand via
`build_runner`.

## Coding Conventions

### Naming

- Files: `snake_case` (enforced by `file_names` lint)
- Classes/widgets: `PascalCase`
- Methods/variables: `camelCase`
- Abstract interfaces: plain name (e.g. `TodoRepository`); implementation:
  name + `Impl`

### Imports

- Always use package imports (`package:todoapp/...`), never relative (enforced
  by `always_use_package_imports` and `avoid_relative_lib_imports`)
- Directives ordered as: `dart:` → `package:` → project (enforced by
  `directives_ordering`)

### Style

- Single quotes (enforced)
- `const` constructors wherever possible (enforced)
- Lines max 80 chars (enforced by `lines_longer_than_80_chars`)
- Curly braces required on all flow control (enforced by
  `curly_braces_in_flow_control_structures`)
- Always declare return types (enforced by `always_declare_return_types`)

### Architecture rules (eagle_eye)

- `data/model/*` must have zero external dependencies
- `*viewmodel.dart` must not depend on `*_screen.dart`
- `util/*_provider.dart` and `util/*_handler.dart` must have zero external
  dependencies

## Testing

### Running tests

```
flutter test
```

Code generation (`build_runner` + `flutter gen-l10n`) must complete before
tests pass.

### Organization

Tests mirror `lib/` structure under `test/` (layer-first).

### Patterns

- **Domain/logic tests:** Pure Dart, no widget testing. Use
  Arrange/Act/Assert with real implementations (no mocking framework).
- **ViewModel (Cubit) tests:** Use `FakeRepository` (in-memory) from
  `test/test_utils/fakes/`. Test initial state, then state transitions after
  method calls.
- **Widget tests:** Wrap with `WidgetsUtil.buildMaterialAppWidgetTest()`
  (sets up MaterialApp + localization delegates, forced English locale). Use
  `testWidgets()`, `pumpWidget()`, `find.byKey()`, `find.text()`.

### Test doubles

Hand-written fakes in `test/test_utils/fakes/` (no mockito):
`FakeRepository`, `FakeNavigatorProvider`, `FakeCallbacks`, `FakeStates`.

## PR & CI

### PR checks (`.github/workflows/pr.yml`)

Triggered on PRs to `main`. Runs on every PR:

1. `flutter gen-l10n` — generate localizations
2. `dart run eagle_eye:main` — check architecture violations
3. `flutter test` — run test suite
4. `dart analyze` — static analysis
5. `flutter build apk --debug` — verify build compiles

All steps must pass before merging.

### Release (`.github/workflows/release_flutter_app.yaml`)

Triggered on any tag push. Builds APK (uploaded to Firebase App Distribution)
and macOS `.app.zip` (attached to GitHub Release).
