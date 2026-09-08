# Contributing to AutoMappr

Thanks for wanting to help! Contributions of all sizes are welcome — bug reports, regression
tests, documentation fixes and features.

If you want to talk something through before writing code, open an
[issue](https://github.com/netglade/auto_mappr/issues) or join us on
[Discord](https://discord.gg/sJfBBuDZy4).

- [Repository layout](#repository-layout)
- [Getting set up](#getting-set-up)
- [Running the tests](#running-the-tests)
- [The development loop](#the-development-loop)
- [Where the code lives](#where-the-code-lives)
- [Writing tests](#writing-tests)
- [Before you open a pull request](#before-you-open-a-pull-request)
- [Pull request conventions](#pull-request-conventions)
- [Changelogs and versioning](#changelogs-and-versioning)
- [Changing the annotation package](#changing-the-annotation-package)
- [Documentation](#documentation)
- [Reporting bugs and proposing changes](#reporting-bugs-and-proposing-changes)

## Repository layout

This is a [Dart pub workspace](https://dart.dev/tools/pub/workspaces) with nine members, managed
with [Melos](https://melos.invertase.dev). Melos scripts live in the root `pubspec.yaml` under the
`melos:` key — there is no `melos.yaml`.

| Path | What it is |
| --- | --- |
| `packages/auto_mappr` | The generator. This is where almost all changes go. |
| `packages/auto_mappr_annotation` | The annotations users put in their code (`@AutoMappr`, `MapType`, `Field`, …). |
| `packages/*/example` | The `example/` directory each published package needs for pub.dev. |
| `examples/example` | A standalone example of everyday usage. |
| `examples/{drift,freezed,injectable,json_serializable}` | Interop examples. These prove the generator plays well with other builders, and they are compiled by CI. |

## Getting set up

You need the **Dart SDK 3.13.0 or newer** (`environment: sdk: ^3.13.0`). Flutter is not required —
CI runs on the plain Dart SDK. The repo does contain an `.fvmrc` pinning Flutter 3.47.2 (which ships
Dart 3.13.2); if you use [FVM](https://fvm.app), prefix the commands below with `fvm`
(`fvm dart …`, `fvm exec melos …`).

```bash
git clone https://github.com/netglade/auto_mappr.git
cd auto_mappr

# One root `pub get` resolves all nine workspace members.
dart pub get

# Generate the code the tests depend on. This step is mandatory — see below.
dart run melos run gen:test:build --no-select

# You should now have a green suite.
dart run melos run test --no-select
```

Two things about that snippet:

- **Run melos through the workspace.** It is a root `dev_dependency` (`melos: ^7.3.0`), so
  `dart run melos <args>` always gives you the same version CI uses. If you would rather have
  `melos` on your `PATH`, pin the major — `dart pub global activate melos 7.8.1` — because the
  latest release is 8.x and its script and filter behaviour differs from what this repository
  targets.
- **`--no-select` skips the package prompt.** Scripts with `packageFilters`
  (`gen:test`, `gen:test:build`, `gen:example`, `gen:example:build`, `test`) ask which package to
  run in. Interactively you can drop `--no-select` and press <kbd>Enter</kbd> for the `*` default,
  which is all of them; in a script or CI job keep the flag, since melos cannot show a prompt
  there. `gen:build-all`, `lint:dart` and `lint:dcm` are unfiltered and never prompt.

`melos bootstrap` is not needed. Under pub workspaces it is just a root `dart pub get` plus IDE file
generation. Running it is harmless.

If you use VS Code, note that `.vscode/settings.json` is committed and sets
`"dart.flutterSdkPath": ".fvm/versions/3.44.0"`. Without FVM the analyzer will not start — either
run `fvm install` once to populate that path, or override the setting in your own user settings. The
command line works either way. The same file sets `dart.lineLength` to 120, which is the line length
this repository formats to.

## Running the tests

**Generated code is not committed for `packages/auto_mappr`, and the tests do not compile without
it.** Every fixture with an `@AutoMappr` class imports its generated file and extends a class that
only exists there:

```dart
import 'enum_mapping.auto_mappr.dart';           // generated

@AutoMappr([MapType<Person, User>()])
class Mappr extends $Mappr {                     // `$Mappr` is defined in the file above
  const Mappr();
}
```

So on a fresh clone, before generation, `dart test` reports
`Error when reading '….auto_mappr.dart': No such file or directory` followed by
`Type '$Mappr' not found.`, and your editor shows
`Target of URI doesn't exist` and `Classes can only extend other classes`. That is a missing build
step, not a broken checkout.

```bash
# From the repository root: everything, in every package that has a test/ directory.
dart run melos run gen:test:build --no-select
dart run melos run test --no-select
```

If regeneration ever seems stuck on stale output, wipe the generated files and start over:

```bash
dart run melos run clean --no-select              # deletes *.auto_mappr.dart, *.g.dart, *.freezed.dart, *.drift.dart
dart run melos run gen:test:build --no-select
```

Be aware that `clean` also deletes the *committed* example output described in
[Before you open a pull request](#before-you-open-a-pull-request);
`git checkout -- examples packages/auto_mappr/example` brings it back. For a narrower reset, remove
one package's build cache: `rm -rf packages/auto_mappr/.dart_tool/build`.

For a tighter loop, drop down to `dart test` inside the package:

```bash
cd packages/auto_mappr

dart test                                              # the whole package
dart test test/integration/record_test.dart            # one file
dart test -n 'Enhanced enum'                           # substring match, regex supported
dart test -N 'Enhanced enum'                           # plain-text substring, no regex
dart test test/builder                                 # unit tests; these need no code generation
```

`dart test` at the repository root does not work — the workspace root has no `test/` directory, so
`cd` into a member package first.

`melos run test` expands to `melos exec -- dart test`. You can append flags after `--`, but melos
re-splits them on whitespace, so `melos run test -- -n 'Enhanced enum with unknown case'` turns into
four bogus test names. Use `cd packages/auto_mappr && dart test …` when you want to filter.

## The development loop

When you change the generator, regenerate and read the output. A change to
`packages/auto_mappr/lib/src/**` is picked up on the next build with no `pub get` or clean needed,
because the workspace resolves `auto_mappr` from source.

```bash
# See the effect on a small, readable example.
# Note: lib/mappr.auto_mappr.dart is tracked, so this will show up in `git status`.
cd packages/auto_mappr/example
dart run build_runner build
cat lib/mappr.auto_mappr.dart

# Or regenerate the test fixtures and run the affected tests.
cd packages/auto_mappr
dart run build_runner build
dart test -n '<your test>'
```

Each example also has a runnable entry point, which is the quickest way to watch a mapping actually
execute instead of reading the generated source:

```bash
cd examples/example && dart run lib/main.dart
# The interop examples work the same way: examples/{drift,freezed,injectable,json_serializable}/lib/main.dart
```

Most of the 20–30s build time is spent compiling the builders, and that cost is paid once per
package; after that an incremental `dart run build_runner build` finishes in a second or two, so
there is no need to narrow the build.

**Do not use `--build-filter` in this repository.** With the current `build_runner` a filtered build
writes the requested output and deletes every other generated file of the package, including the
committed `example/lib/mappr.auto_mappr.dart`. The symptom is hundreds of "The method 'convert'
isn't defined" analyzer errors. If that happens, run the full build again.

You can also leave a watcher running in a second terminal:

```bash
dart run melos run gen:test --no-select        # test fixtures
dart run melos run gen:example --no-select     # examples
```

## Where the code lives

The generator is a `source_gen` `GeneratorForAnnotation<AutoMappr>` wrapped in a `LibraryBuilder`
that emits `.auto_mappr.dart` next to the source file. Roughly:

> annotation → `DartObject`s → `TypeMapping` / `FieldMapping` / `TypeConverter` → `AutoMapprConfig`
> → `AutoMapprBuilder` → method builders → per-mapping body builder → per-field assignment builder
> → `code_builder` `Library` → formatted source

If you are new to the codebase, read these in order:

1. `packages/auto_mappr/build.yaml` — how the builder is wired up (runs after `freezed` and `drift`).
2. `packages/auto_mappr/lib/auto_mappr.dart` — the entry point.
3. `packages/auto_mappr_annotation/lib/src/auto_mappr_interface.dart` — the contract the generated
   class satisfies. Read this before the builders, or the list of generated methods looks arbitrary.
4. `packages/auto_mappr/lib/src/generator/auto_mappr_generator.dart` — decoding the annotation,
   resolving `includes`, reverse mappings, duplicate detection.
5. `packages/auto_mappr/lib/src/builder/auto_mappr_builder.dart` — `_buildMethods()` is the table of
   contents for the generated class.
6. `packages/auto_mappr/lib/src/builder/map_bodies/class_body_builder.dart` — constructor selection,
   field matching, renames, ignores. The largest and most consequential file.
7. `packages/auto_mappr/lib/src/builder/value_assignment_builder.dart` — how a single field's value
   is produced, and the dispatch order over `src/builder/assignments/*`.

Common changes and where they go:

| You want to change | Edit |
| --- | --- |
| The public API of the generated mapper | `src/builder/auto_mappr_builder.dart` (`_buildMethods()`) plus the relevant `src/builder/methods/*`. Keep it in sync with `AutoMapprInterface` in `auto_mappr_annotation`: a member declared there but not emitted (or emitted with a different signature) breaks the generated `implements` clause, and callers that hold a mapper as an `AutoMapprInterface` — delegates, for instance — can only reach members the interface declares. |
| How a single field is assigned | `src/builder/value_assignment_builder.dart`, and `src/models/field_mapping.dart` for `ignore` / `custom` semantics. |
| Iterable, map or record mapping | `src/builder/assignments/{iterable,map,record}_assignment_builder.dart`; the eligibility predicates are in `src/models/source_assignment.dart`. |
| The public `convertIterable` / `convertList` / `convertSet` | `src/builder/methods/{convert,try_convert}_iterable_method_builder.dart`. |
| Enum mapping | `src/builder/map_bodies/enum_body_builder.dart`. |

Two things that are surprising at first:

- **`runZonedAutoMappr` supplies the emitter.** `EmitterHelper` is stored as a zone value, so any
  builder — including `toString()` inside error messages — can emit code with the right import
  prefixes without threading an emitter through constructors. Code that touches the emitter outside
  such a zone throws, which is why unit tests wrap their bodies in `runZonedAutoMappr(() { … })`.
- **Nullable mapping methods are generated in two passes.** The non-nullable methods are built first
  with a callback; anything that emits a call to a `_Nullable` variant records it, and only the
  recorded ones are emitted at the end.

## Writing tests

Almost all coverage is behavioural: generate a mapper from a fixture, then assert on what it
produces at runtime.

- **`test/integration/`** — the main suite. One `*_test.dart` per feature, with its fixture in
  `test/integration/fixture/`.
- **`test/integration/regressions/`** — reserved for fixes that have no natural feature home. Their
  fixtures live in `test/integration/fixture/regression/` (singular).
- **`test/builder/`** — unit tests that construct a method builder directly and assert on the
  resulting `code_builder` `Method`. These need no code generation.

### Adding an integration test

Follow the house style:

```dart
// test/integration/fixture/my_feature.dart
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'my_feature.auto_mappr.dart';

@AutoMappr([MapType<SourceDto, Target>()])
class Mappr extends $Mappr {
  const Mappr();
}

class SourceDto {
  final String name;

  const SourceDto({required this.name});
}

class Target with Equatable {
  final String name;

  @override
  List<Object?> get props => [name];

  const Target({required this.name});
}
```

```dart
// test/integration/my_feature_test.dart
import 'package:test/test.dart';

import 'fixture/my_feature.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Maps SourceDto to Target', () {
    // arrange
    const dto = fixture.SourceDto(name: 'Alice');

    // act
    final result = mappr.convert<fixture.SourceDto, fixture.Target>(dto);

    // assert
    expect(result, equals(const fixture.Target(name: 'Alice')));
  });
}
```

Notes:

- Target classes use `Equatable` as a mixin so `expect(result, equals(…))` compares by value. The
  house style declares fields first, then `props`, then the constructor.
- Fixtures are exempt from `avoid-top-level-members-in-tests` and
  `prefer-single-declaration-per-file`, so several classes and top-level helpers in one fixture file
  are fine.
- Run `dart run melos run gen:test:build --no-select` after adding a fixture — the test will not
  compile before that.

There is currently no harness for asserting that the generator *rejects* bad input, so if your
change adds or alters an `InvalidGenerationSourceError`, mention that in the pull request rather
than trying to fit it into the integration suite.

### Fixing a reported bug

Add a test that fails before your fix and passes after it. If the bug belongs to an existing feature
area, extend that feature's test and fixture. Only if it has no natural home, add
`test/integration/fixture/regression/<slug>_issue_<number>.dart` and
`test/integration/regressions/<slug>_issue_<number>_test.dart`, using a descriptive slug rather than
a bare issue number.

## Before you open a pull request

Reproduce CI locally. CI runs `pub get` → `gen:build-all` → `lint:dart` → `lint:dcm` → `test`:

```bash
dart pub get
dart run melos run gen:build-all --no-select   # generate everything, all nine packages
dart run melos run lint:dart                   # must report "No issues found!"
# dart run melos run lint:dcm                  # CI runs this here; see below before you skip it
dart run melos run test --no-select            # must be green
```

### Generated example output is committed

`packages/auto_mappr`'s own generated files are gitignored, but the examples' are not — their
`.gitignore` files re-include them with `!*.auto_mappr.dart`. Eleven `.auto_mappr.dart` files under
`examples/` and `packages/auto_mappr/example/` are tracked, plus
`examples/injectable/lib/getit.config.dart`, which `injectable` regenerates at the same time.

So `melos run gen:build-all` can leave up to twelve modified files in `git status` even when you
changed nothing relevant. Look at the diff before deciding what to do with them:

- **Your change altered the generated output.** Commit the regenerated example files with your pull
  request — reviewers read that diff to see what your change does.
- **You changed nothing relevant and they still moved.** The committed output was formatted by an
  older SDK, so you get a reflow of the `// ignore_for_file:` header. Revert it rather than mixing
  unrelated churn into your pull request:

  ```bash
  git checkout -- examples packages/auto_mappr/example
  ```

`git diff --stat` plus `git diff` on one file is enough to tell a real mapping change from a header
reflow.

### DCM

CI also runs `melos run lint:dcm`. [DCM](https://dcm.dev) is a commercial analyzer and the version
is pinned in `dcm_global.yaml`; CI installs that exact version via `CQLabs/setup-dcm@v2` with
`version: auto`. If you do not have it (installation instructions are at
[dcm.dev](https://dcm.dev/docs/getting-started/installation)), skip this step locally and let CI
report. Two things to know if you do run it:

- Each package has a committed `dcm_baseline.json` that suppresses pre-existing findings, recorded
  with `"sensitivity": "exact"` — a baselined finding comes back if you change the flagged code
  itself, but not merely because lines around it moved. Prefer fixing such a finding over
  re-baselining; a growing baseline diff will be questioned in review.
- If you genuinely need to regenerate baselines, run `dcm init baseline --all -t exact .` from the
  repository root with the pinned version installed, so all packages stay consistent.

Lints come from [`netglade_analysis`](https://pub.dev/packages/netglade_analysis). Where a rule has
to be suppressed, use a targeted `// ignore:` with a short reason, matching the existing style.

## Pull request conventions

These apply going forward; older commits and branches in this repository do not all follow them.

- Branch off `main`. Name the branch `fix/<issue-number>-<short-slug>` when it addresses a filed
  issue, otherwise `fix/<short-slug>`, `feat/<short-slug>` or `chore/<short-slug>`. Use kebab-case.
- Write commit subjects as short imperative sentences (`Fix nullable map assignment`). Conventional
  Commits are not used in this repository.
- Keep the pull request focused, describe what changed and why, and link the issue it fixes.
- Pull requests are merged with a merge commit, so your individual commits stay in the history —
  keep them tidy, but there is no need to squash into one.
- Every code change needs a test, and every user-visible change needs a changelog entry.

## Changelogs and versioning

Versioning is manual; `melos version` is not configured for this repository, so please do not run it.

Add your entry to the changelog of the package you changed
(`packages/auto_mappr/CHANGELOG.md` or `packages/auto_mappr_annotation/CHANGELOG.md`), following the
existing format: a `## <version>` heading with no date, newest first, and a flat list of bullets
starting with a capitalised verb — nest bullets only for a list of dependency bumps, as in
`## 2.11.0`. Wrap identifiers, package names and versions in backticks, and link the issue or pull
request at the end of the bullet where there is one.

```md
## 2.15.1
- Fix generation failing when the same mappr is included multiple times in the includes hierarchy. [#256](https://github.com/netglade/auto_mappr/issues/256)
```

The top of each changelog holds a commented-out `[//]: # (## Unreleased)` heading. Uncomment it and
put your bullet underneath while the change is unreleased.

**Leave `version:` in `packages/auto_mappr/pubspec.yaml` alone** unless a maintainer asks you to bump
it — the maintainer decides the number and cuts the release. Do not create git tags. Some merged pull
requests have included their own bump, so if you are unsure, ask in the pull request rather than
guessing. The annotation package is the one exception; see below.

## Changing the annotation package

`auto_mappr` depends on `auto_mappr_annotation` by version constraint, not by path. Locally the
workspace resolves the annotation from source, so a new annotation API satisfies the existing
constraint immediately — everything passes locally *and* in CI, while the published `auto_mappr`
would break for users who get the older published annotation package. CI cannot catch that, so the
version bump has to be done by hand and is part of your change.

When you change `packages/auto_mappr_annotation/lib/`:

1. Bump `version:` in `packages/auto_mappr_annotation/pubspec.yaml`.
2. Add an entry to `packages/auto_mappr_annotation/CHANGELOG.md`.
3. If the generator relies on the new annotation API, raise the `auto_mappr_annotation` constraint in
   `packages/auto_mappr/pubspec.yaml`. Note that pub validates this against the sibling's declared
   version, so the two must move together or the root `dart pub get` fails.
4. Note that constraint bump in `packages/auto_mappr/CHANGELOG.md`, for example
   ``- Bump `auto_mappr_annotation` version to `^2.4.0`.``

The `example` packages pin their own constraints, but because the workspace resolves them locally
they only need updating when a major bump would fall outside their caret range.

## Documentation

The root `README.md` is a symlink to `packages/auto_mappr/README.md` — edit the file in the package.
Any new user-facing option, such as a new `MapType` or `Field` parameter, needs a README section with
a short example alongside the code change.

## Reporting bugs and proposing changes

Pick the right template at
[New issue](https://github.com/netglade/auto_mappr/issues/new/choose):

- **Bug report** — the generator produces wrong code or throws.
- **Feature request** — a new `MapType` or `Field` option, or a new generator capability.
- **Question** — usage, or documentation you found unclear.

The bug template's "Version info" field only asks for the package version. Please also paste, under
"Additional context", your Dart SDK version (`dart --version`), the source and target classes, your
`@AutoMappr` annotation, and the generated `.auto_mappr.dart` output or the exact generator error. A
minimal reproduction is by far the most useful thing you can attach — ideally shaped like a fixture
in `packages/auto_mappr/test/integration/fixture/`.
