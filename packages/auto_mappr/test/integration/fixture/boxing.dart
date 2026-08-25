import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'boxing.auto_mappr.dart';

/// Wraps a value the same way drift's `Value` does.
// ignore: prefer-static-class, top level on purpose, that is how boxing is documented
Value<T> box<T>(T value) => Value(value);

/// Unwraps a boxed value.
// ignore: prefer-static-class, top level on purpose, that is how boxing is documented
T unbox<T>(Value<T> value) => value.value;

@AutoMappr([
  // Both directions of the same box type.
  MapType<Todo, TodoCompanion>(boxing: box, unboxing: unbox, reverse: true),
  // Nested objects inside the box.
  MapType<Author, AuthorEntity>(reverse: true),
  MapType<Book, BookCompanion>(boxing: box, unboxing: unbox, reverse: true),
  // Iterables inside the box.
  MapType<Tags, TagsCompanion>(boxing: box, unboxing: unbox, reverse: true),
  // Already boxed source fields and plain fields next to boxed ones.
  MapType<Mixed, MixedCompanion>(boxing: box, unboxing: unbox),
  // Field level opt-out falls back to a type converter.
  MapType<OptOut, OptOutCompanion>(
    boxing: box,
    fields: [Field('viaConverter', boxing: false)],
    converters: [TypeConverter<int, Value<int>>(Mappr.intToTenfoldValue)],
  ),
  // A custom mapping provides the whole value, including the box.
  MapType<Custom, CustomCompanion>(
    boxing: box,
    fields: [Field.custom('viaCustom', custom: Mappr.customValue)],
  ),
  // Unboxing on its own, without boxing.
  MapType<OnlyUnbox, OnlyUnboxTarget>(unboxing: unbox),
  // An ignored boxed field is left out so the box's own default applies.
  MapType<Ignored, IgnoredCompanion>(boxing: box, fields: [Field.ignore('skip')]),
  // Nullable source mapped into a non-nullable boxed target.
  MapType<Nullable, NullableCompanion>(boxing: box, ignoreFieldNull: true),
])
class Mappr extends $Mappr {
  const Mappr();

  static Value<int> intToTenfoldValue(int source) => Value(source * 10);

  static Value<String> customValue(Custom dto) => Value('custom-${dto.viaCustom}');
}

/// A stand-in for drift's `Value`, including the absent state.
class Value<T> with Equatable {
  final bool present;

  final T? _value;

  T get value => _value as T;

  @override
  List<Object?> get props => [_value, present];

  const Value(T value)
      : _value = value,
        present = true;

  const Value.absent()
      : _value = null,
        present = false;
}

// Primitives, both directions.

class Todo with Equatable {
  final int id;
  final String title;
  final bool done;

  @override
  List<Object?> get props => [id, title, done];

  const Todo({required this.id, required this.title, required this.done});
}

class TodoCompanion with Equatable {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> done;

  @override
  List<Object?> get props => [id, title, done];

  const TodoCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.done = const Value.absent(),
  });
}

// Nested objects inside the box.

class Author with Equatable {
  final String name;

  @override
  List<Object?> get props => [name];

  const Author(this.name);
}

class AuthorEntity with Equatable {
  final String name;

  @override
  List<Object?> get props => [name];

  const AuthorEntity(this.name);
}

class Book with Equatable {
  final Author author;

  @override
  List<Object?> get props => [author];

  const Book(this.author);
}

class BookCompanion with Equatable {
  final Value<AuthorEntity> author;

  @override
  List<Object?> get props => [author];

  const BookCompanion({this.author = const Value.absent()});
}

// Iterables inside the box.

class Tags with Equatable {
  final List<String> values;

  @override
  List<Object?> get props => [values];

  const Tags(this.values);
}

class TagsCompanion with Equatable {
  final Value<List<String>> values;

  @override
  List<Object?> get props => [values];

  const TagsCompanion({this.values = const Value.absent()});
}

// Already boxed source fields and plain fields.

class Mixed with Equatable {
  final int boxed;
  final Value<int> alreadyBoxed;
  final String plain;

  @override
  List<Object?> get props => [boxed, alreadyBoxed, plain];

  const Mixed({required this.boxed, required this.alreadyBoxed, required this.plain});
}

class MixedCompanion with Equatable {
  final Value<int> boxed;
  final Value<int> alreadyBoxed;
  final String plain;

  @override
  List<Object?> get props => [boxed, alreadyBoxed, plain];

  const MixedCompanion({
    required this.plain,
    this.boxed = const Value.absent(),
    this.alreadyBoxed = const Value.absent(),
  });
}

// Field level opt-out.

class OptOut with Equatable {
  final int viaConverter;
  final int viaBox;

  @override
  List<Object?> get props => [viaConverter, viaBox];

  const OptOut({required this.viaConverter, required this.viaBox});
}

class OptOutCompanion with Equatable {
  final Value<int> viaConverter;
  final Value<int> viaBox;

  @override
  List<Object?> get props => [viaConverter, viaBox];

  const OptOutCompanion({
    this.viaConverter = const Value.absent(),
    this.viaBox = const Value.absent(),
  });
}

// Custom mapping.

class Custom with Equatable {
  final String viaCustom;
  final String viaBox;

  @override
  List<Object?> get props => [viaCustom, viaBox];

  const Custom({required this.viaCustom, required this.viaBox});
}

class CustomCompanion with Equatable {
  final Value<String> viaCustom;
  final Value<String> viaBox;

  @override
  List<Object?> get props => [viaCustom, viaBox];

  const CustomCompanion({
    this.viaCustom = const Value.absent(),
    this.viaBox = const Value.absent(),
  });
}

// Unboxing without boxing.

class OnlyUnbox with Equatable {
  final Value<int> amount;

  @override
  List<Object?> get props => [amount];

  const OnlyUnbox(this.amount);
}

class OnlyUnboxTarget with Equatable {
  final int amount;

  @override
  List<Object?> get props => [amount];

  const OnlyUnboxTarget(this.amount);
}

// Ignored boxed field.

class Ignored with Equatable {
  final int keep;
  final int skip;

  @override
  List<Object?> get props => [keep, skip];

  const Ignored({required this.keep, required this.skip});
}

class IgnoredCompanion with Equatable {
  final Value<int> keep;
  final Value<int> skip;

  @override
  List<Object?> get props => [keep, skip];

  const IgnoredCompanion({
    this.keep = const Value.absent(),
    this.skip = const Value.absent(),
  });
}

// Nullable source into a non-nullable boxed target.

class Nullable with Equatable {
  final int? amount;

  @override
  List<Object?> get props => [amount];

  const Nullable(this.amount);
}

class NullableCompanion with Equatable {
  final Value<int> amount;

  @override
  List<Object?> get props => [amount];

  const NullableCompanion({this.amount = const Value.absent()});
}
