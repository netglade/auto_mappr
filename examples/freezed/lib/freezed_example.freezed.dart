// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserInfoUnion {

 String get email; String get loginIdentifier; DateTime get updatedAt; int get primarySectionId;
/// Create a copy of UserInfoUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoUnionCopyWith<UserInfoUnion> get copyWith => _$UserInfoUnionCopyWithImpl<UserInfoUnion>(this as UserInfoUnion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoUnion&&(identical(other.email, email) || other.email == email)&&(identical(other.loginIdentifier, loginIdentifier) || other.loginIdentifier == loginIdentifier)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.primarySectionId, primarySectionId) || other.primarySectionId == primarySectionId));
}


@override
int get hashCode => Object.hash(runtimeType,email,loginIdentifier,updatedAt,primarySectionId);

@override
String toString() {
  return 'UserInfoUnion(email: $email, loginIdentifier: $loginIdentifier, updatedAt: $updatedAt, primarySectionId: $primarySectionId)';
}


}

/// @nodoc
abstract mixin class $UserInfoUnionCopyWith<$Res>  {
  factory $UserInfoUnionCopyWith(UserInfoUnion value, $Res Function(UserInfoUnion) _then) = _$UserInfoUnionCopyWithImpl;
@useResult
$Res call({
 String email, String loginIdentifier, DateTime updatedAt, int primarySectionId
});




}
/// @nodoc
class _$UserInfoUnionCopyWithImpl<$Res>
    implements $UserInfoUnionCopyWith<$Res> {
  _$UserInfoUnionCopyWithImpl(this._self, this._then);

  final UserInfoUnion _self;
  final $Res Function(UserInfoUnion) _then;

/// Create a copy of UserInfoUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? loginIdentifier = null,Object? updatedAt = null,Object? primarySectionId = null,}) {
  return _then(UserInfoUnion(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,loginIdentifier: null == loginIdentifier ? _self.loginIdentifier : loginIdentifier // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,primarySectionId: null == primarySectionId ? _self.primarySectionId : primarySectionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoUnion].
extension UserInfoUnionPatterns on UserInfoUnion {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
