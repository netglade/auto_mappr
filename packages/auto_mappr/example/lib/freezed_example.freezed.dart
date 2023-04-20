// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserInfoUnion {
  int? get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get loginIdentifier => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get primarySectionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserInfoUnionCopyWith<UserInfoUnion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoUnionCopyWith<$Res> {
  factory $UserInfoUnionCopyWith(
          UserInfoUnion value, $Res Function(UserInfoUnion) then) =
      _$UserInfoUnionCopyWithImpl<$Res, UserInfoUnion>;
  @useResult
  $Res call(
      {int? id,
      String email,
      String loginIdentifier,
      DateTime updatedAt,
      int primarySectionId});
}

/// @nodoc
class _$UserInfoUnionCopyWithImpl<$Res, $Val extends UserInfoUnion>
    implements $UserInfoUnionCopyWith<$Res> {
  _$UserInfoUnionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? loginIdentifier = null,
    Object? updatedAt = null,
    Object? primarySectionId = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      loginIdentifier: null == loginIdentifier
          ? _value.loginIdentifier
          : loginIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      primarySectionId: null == primarySectionId
          ? _value.primarySectionId
          : primarySectionId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoCopyWith<$Res>
    implements $UserInfoUnionCopyWith<$Res> {
  factory _$$UserInfoCopyWith(
          _$UserInfo value, $Res Function(_$UserInfo) then) =
      __$$UserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String email,
      String loginIdentifier,
      DateTime updatedAt,
      int primarySectionId});
}

/// @nodoc
class __$$UserInfoCopyWithImpl<$Res>
    extends _$UserInfoUnionCopyWithImpl<$Res, _$UserInfo>
    implements _$$UserInfoCopyWith<$Res> {
  __$$UserInfoCopyWithImpl(_$UserInfo _value, $Res Function(_$UserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? loginIdentifier = null,
    Object? updatedAt = null,
    Object? primarySectionId = null,
  }) {
    return _then(_$UserInfo(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      loginIdentifier: null == loginIdentifier
          ? _value.loginIdentifier
          : loginIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      primarySectionId: null == primarySectionId
          ? _value.primarySectionId
          : primarySectionId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserInfo implements UserInfo {
  _$UserInfo(
      {this.id,
      required this.email,
      required this.loginIdentifier,
      required this.updatedAt,
      this.primarySectionId = 0});

  @override
  final int? id;
  @override
  final String email;
  @override
  final String loginIdentifier;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final int primarySectionId;

  @override
  String toString() {
    return 'UserInfoUnion(id: $id, email: $email, loginIdentifier: $loginIdentifier, updatedAt: $updatedAt, primarySectionId: $primarySectionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.loginIdentifier, loginIdentifier) ||
                other.loginIdentifier == loginIdentifier) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.primarySectionId, primarySectionId) ||
                other.primarySectionId == primarySectionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, loginIdentifier, updatedAt, primarySectionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoCopyWith<_$UserInfo> get copyWith =>
      __$$UserInfoCopyWithImpl<_$UserInfo>(this, _$identity);
}

abstract class UserInfo implements UserInfoUnion {
  factory UserInfo(
      {final int? id,
      required final String email,
      required final String loginIdentifier,
      required final DateTime updatedAt,
      final int primarySectionId}) = _$UserInfo;

  @override
  int? get id;
  @override
  String get email;
  @override
  String get loginIdentifier;
  @override
  DateTime get updatedAt;
  @override
  int get primarySectionId;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoCopyWith<_$UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
