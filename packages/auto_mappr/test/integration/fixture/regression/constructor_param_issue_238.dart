import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'constructor_param_issue_238.auto_mappr.dart';

@AutoMappr([
  MapType<Source, Target>(constructor: 'foo'),
  MapType<Source, PositionalTarget>(constructor: 'foo'),
  MapType<Source, IgnoredTarget>(
    constructor: 'foo',
    fields: [Field('a', ignore: true)],
  ),
  MapType<NestedSource, NestedTarget>(constructor: 'foo'),
  MapType<InnerSource, InnerTarget>(),
])
class Issue238Mappr extends $Issue238Mappr {
  const Issue238Mappr();
}

class Source with Equatable {
  final int a;

  @override
  List<Object?> get props => [a];

  const Source({required this.a});
}

class Target with Equatable {
  final int secret;

  @override
  List<Object?> get props => [secret];

  const Target({required this.secret});

  const Target.foo({required int a}) : this(secret: a);
}

class PositionalTarget with Equatable {
  final int secret;

  @override
  List<Object?> get props => [secret];

  const PositionalTarget(this.secret);

  const PositionalTarget.foo(int a) : this(a);
}

class IgnoredTarget with Equatable {
  final int? secret;

  @override
  List<Object?> get props => [secret];

  const IgnoredTarget(this.secret);

  const IgnoredTarget.foo({int? a}) : this(a);
}

class InnerSource with Equatable {
  final String x;

  @override
  List<Object?> get props => [x];

  const InnerSource(this.x);
}

class InnerTarget with Equatable {
  final String x;

  @override
  List<Object?> get props => [x];

  const InnerTarget(this.x);
}

class NestedSource with Equatable {
  final InnerSource a;

  @override
  List<Object?> get props => [a];

  const NestedSource({required this.a});
}

class NestedTarget with Equatable {
  final InnerTarget secret;

  @override
  List<Object?> get props => [secret];

  const NestedTarget({required this.secret});

  NestedTarget.foo({required InnerTarget a}) : this(secret: a);
}
