// ignore_for_file: prefer-named-boolean-parameters, avoid_positional_boolean_parameters

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'type_converters.auto_mappr.dart';
import 'type_converters/module_alpha.dart';

@AutoMappr(
  [
    MapType<PrimitivesDto, Primitives>(
      converters: [TypeConverter<Object, String>(Mappr.objectToString)],
    ),
    MapType<NullableDto, Nullable>(
      converters: [
        TypeConverter<int, Value<int>>(Mappr.intToValueInt),
      ],
    ),
    MapType<NormalFieldDto, NormalField>(
      converters: [TypeConverter<int, Value<int>>(Mappr.intToValueInt)],
    ),
    MapType<InListDto, InList>(),
    MapType<InMapDto, InMap>(),
    MapType<IncludesDto, Includes>(),
    // Post w/ reverse.
    MapType<PostDto, Post>(reverse: true),
  ],
  converters: [
    TypeConverter<String, Value<String>>(Mappr.stringToValueString),
    TypeConverter<Object, Value<Object>>(Mappr.objectToValueObject2),
    // Post w/ reverse.
    userDtoConverter,
    userConverter,
  ],
  includes: [MapprAlpha()],
)
class Mappr extends $Mappr {
  const Mappr();

  static String objectToString<T extends Object>(T source) {
    return '--- $source ---';
  }

  static Value<T> objectToValueObject<T extends Object>(T source) {
    return Value<T>(source);
  }

  static Value<Object> objectToValueObject2(Object source) {
    if (source is int) {
      return Value<int>(source);
    }

    return Value(source);
  }

  static Value<int> intToValueInt(int source) {
    return Value(source);
  }

  static Value<String> stringToValueString(String source) {
    return Value(source);
  }
}

// Nullables.

class NullableDto {
  final int? alpha;
  final int? beta;

  const NullableDto({required this.alpha, required this.beta});
}

class Nullable with EquatableMixin {
  final Value<int>? alpha;
  final int? beta;

  @override
  List<Object?> get props => [alpha, beta];

  const Nullable(this.alpha, this.beta);
}

// Primitives.

class PrimitivesDto {
  final int alpha;
  final bool beta;

  const PrimitivesDto({required this.alpha, required this.beta});
}

class Primitives with EquatableMixin {
  final String alpha;
  final String beta;

  @override
  List<Object?> get props => [alpha, beta];

  const Primitives(this.alpha, this.beta);
}

// Fields.

class NormalFieldDto {
  final int xInt;
  final String xString;
  final bool normalBool;

  const NormalFieldDto({
    required this.xInt,
    required this.xString,
    required this.normalBool,
  });
}

class NormalField with EquatableMixin {
  final Value<int> xInt;
  final Value<String> xString;
  final bool normalBool;

  @override
  List<Object?> get props => [xInt, xString, normalBool];

  const NormalField(this.xInt, this.xString, this.normalBool);
}

// In list.

class InListDto {
  final List<int> xInt;
  final String xString;
  final bool normalBool;

  const InListDto({
    required this.xInt,
    required this.xString,
    required this.normalBool,
  });
}

class InList with EquatableMixin {
  final List<Value<int>> xInt;
  final Value<String> xString;
  final bool normalBool;

  @override
  List<Object?> get props => [xInt, xString, normalBool];

  const InList(this.xInt, this.xString, this.normalBool);
}

// In map.

class InMapDto {
  final Map<String, int> alpha;
  final Map<String, int> beta;
  final Map<String, int> gama;

  const InMapDto({required this.alpha, required this.beta, required this.gama});
}

class InMap with EquatableMixin {
  final Map<Value<String>, int> alpha;
  final Map<String, Value<int>> beta;
  final Map<Value<String>, Value<int>> gama;

  @override
  List<Object?> get props => [alpha, beta, gama];

  const InMap(this.alpha, this.beta, this.gama);
}

// Includes.

class IncludesDto {
  final int alpha;

  const IncludesDto({required this.alpha});
}

class Includes with EquatableMixin {
  final bool alpha;

  @override
  List<Object?> get props => [alpha];

  const Includes(this.alpha);
}

// Box

class Value<T> with EquatableMixin {
  final T value;

  @override
  List<Object?> get props => [value];

  const Value(this.value);
}

// Post w/ reverse.

class Post with EquatableMixin {
  final User user;

  @override
  List<Object?> get props => [user];

  const Post({required this.user});
}

class PostDto with EquatableMixin {
  final UserDto user;

  @override
  List<Object?> get props => [user];

  const PostDto({required this.user});
}

class User with EquatableMixin {
  final String id;

  @override
  List<Object?> get props => [id];

  const User({required this.id});
}

class UserDto with EquatableMixin {
  final String id;

  @override
  List<Object?> get props => [id];

  const UserDto({required this.id});
}

const userDtoConverter = TypeConverter(userDtoToUser);
const userConverter = TypeConverter(userToUserDto);
UserDto userToUserDto(User source) => UserDto(id: source.id);
User userDtoToUser(UserDto source) => User(id: source.id);

// Nullable

class RequiredInput {
  final String xString;

  const RequiredInput(this.xString);
}

class RequiredOutput with EquatableMixin {
  final Value<String> xString;

  @override
  List<Object?> get props => [xString];

  const RequiredOutput(this.xString);
}

class NullableInput {
  final String? xString;

  const NullableInput(this.xString);
}

class NullableOutput with EquatableMixin {
  final Value<String>? xString;

  @override
  List<Object?> get props => [xString];
  const NullableOutput(this.xString);
}
