// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

ValueHolderDto _$ValueHolderDtoFromJson(Map<String, dynamic> json) =>
    ValueHolderDto(json['json'] as Map<String, dynamic>);

Map<String, dynamic> _$ValueHolderDtoToJson(ValueHolderDto instance) =>
    <String, dynamic>{'json': instance.json};
