import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_serializable.g.dart';

@AutoMapper([
  MapType<UserDto, User>(),
  MapType<ValueHolderDto, ValueHolder>(),
])
class Mapper extends $Mapper {}

class User {
  final String firstName;
  final String lastName;

  const User({
    required this.firstName,
    required this.lastName,
  });
}

@JsonSerializable()
class UserDto {
  final String firstName;
  final String lastName;

  const UserDto({
    required this.firstName,
    required this.lastName,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

// second

class ValueHolder {
  final Map<String, dynamic> json;

  const ValueHolder(this.json);
}

@JsonSerializable()
class ValueHolderDto {
  final Map<String, dynamic> json;

  const ValueHolderDto(this.json);

  factory ValueHolderDto.fromJson(Map<String, dynamic> json) => _$ValueHolderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ValueHolderDtoToJson(this);
}
