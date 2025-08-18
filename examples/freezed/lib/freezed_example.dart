import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:examples_freezed/freezed_example.auto_mappr.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_example.freezed.dart';

@freezed
class UserInfoUnion with _$UserInfoUnion {
  UserInfoUnion({
    required this.email,
    required this.loginIdentifier,
    required this.updatedAt,
    this.primarySectionId = 0,
  });

  @override
  final String email;
  @override
  final String loginIdentifier;
  @override
  final DateTime updatedAt;
  @override
  final int primarySectionId;
}

class UserInfoCompanion {
  final String email;
  final String loginIdentifier;
  final DateTime updatedAt;

  UserInfoCompanion({
    required this.email,
    required this.loginIdentifier,
    required this.updatedAt,
  });
}

@AutoMappr([
  MapType<UserInfoUnion, UserInfoCompanion>(),
])
class Mappr extends $Mappr {}
