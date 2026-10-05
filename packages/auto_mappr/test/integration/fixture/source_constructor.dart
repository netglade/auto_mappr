import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'source_constructor.auto_mappr.dart';

@AutoMappr([
  // Both directions select a named constructor.
  MapType<Source, Target>(
    targetConstructor: 'fromSource',
    sourceConstructor: 'fromTarget',
    reverse: true,
  ),
  // Only the forward direction selects a named constructor,
  // the reverse one falls back to the default constructor.
  MapType<Source, DefaultReverseTarget>(targetConstructor: 'fromSource', reverse: true),
  // Both classes declare a `shared` constructor, but only the target's is selected.
  MapType<SharedNameSource, SharedNameTarget>(targetConstructor: 'shared', reverse: true),
  // Both selected constructors take parameters named differently
  // than their own class' fields. See issue #238.
  MapType<NonCorrespondingSource, NonCorrespondingTarget>(
    targetConstructor: 'fromSource',
    sourceConstructor: 'fromTarget',
    reverse: true,
  ),
])
class SourceConstructorMappr extends $SourceConstructorMappr {
  const SourceConstructorMappr();
}

class Source with Equatable {
  final String name;
  final String note;

  @override
  List<Object?> get props => [name, note];

  const Source({required this.name, required this.note});

  const Source.fromTarget({required String name, required String note}) : this(name: name, note: 'reversed: $note');
}

class Target with Equatable {
  final String name;
  final String note;

  @override
  List<Object?> get props => [name, note];

  const Target({required this.name, required this.note});

  const Target.fromSource({required String name, required String note}) : this(name: name, note: 'forward: $note');
}

class DefaultReverseTarget with Equatable {
  final String name;
  final String note;

  @override
  List<Object?> get props => [name, note];

  const DefaultReverseTarget({required this.name, required this.note});

  const DefaultReverseTarget.fromSource({required String name, required String note})
    : this(name: name, note: 'forward: $note');
}

class SharedNameSource with Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const SharedNameSource({required this.value});

  const SharedNameSource.shared({required String value}) : this(value: 'source-shared: $value');
}

class SharedNameTarget with Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const SharedNameTarget({required this.value});

  const SharedNameTarget.shared({required String value}) : this(value: 'target-shared: $value');
}

class NonCorrespondingSource with Equatable {
  final String secret;

  @override
  List<Object?> get props => [secret];

  const NonCorrespondingSource({required this.secret});

  /// Takes `value`, which is not a field of this class.
  const NonCorrespondingSource.fromTarget({required String value}) : this(secret: 'reversed: $value');
}

class NonCorrespondingTarget with Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const NonCorrespondingTarget({required this.value});

  /// Takes `secret`, which is not a field of this class.
  const NonCorrespondingTarget.fromSource({required String secret}) : this(value: 'forward: $secret');
}
