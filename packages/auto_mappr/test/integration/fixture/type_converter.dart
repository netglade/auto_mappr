import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'type_converter.g.dart';

class DateDomain {
  final DateTime? dateTimeA;
  final DateTime? dateTimeB;
  final DateTime? dateTimeC;

  DateDomain({
    required this.dateTimeA,
    required this.dateTimeB,
    required this.dateTimeC,
  });
}

class DateDto {
  final String dateTimeA;
  final String dateTimeB;
  final String dateTimeC;

  DateDto({
    required this.dateTimeA,
    required this.dateTimeB,
    required this.dateTimeC,
  });
}

class DateDto2 {
  final String dateTimeA;
  final String dateTimeB;

  DateDto2({
    required this.dateTimeA,
    required this.dateTimeB,
  });
}

class UserId extends Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const UserId(this.value);
}

class AccountId extends Equatable {
  final String value;

  @override
  List<Object?> get props => [value];

  const AccountId(this.value);
}

class User {
  final UserId? id;
  final AccountId? accountId;

  User(this.id, this.accountId);
}

class UserDto {
  final String? id;
  final String? accountId;

  UserDto(this.id, this.accountId);
}


@AutoMappr(
  [
    MapType<DateDto, DateDomain>(
      fields: [
        Field(
          'dateTimeA',
          type: TypeConverter<String, DateTime>(Mappr.tryParseFirstOfDecemberInYear),
        ),
      ],
      types: [
        TypeConverter<String, DateTime>(Mappr.parseSecondOfDecemberInYear),
      ],
    ),
    MapType<DateDto2, DateDomain>(),
    MapType<UserDto, User>(
      fields: [
        Field('id', type: TypeConverter<String, UserId>(UserId.new)),
        Field('accountId', type: TypeConverter<String, AccountId>(AccountId.new)),
      ],
    ),
  ],
  types: [
    TypeConverter<String, DateTime>(Mappr.parseISO8601),
  ],
)
class Mappr extends $Mappr {
  /// Expects a year as input and returns the first of december in that year.
  ///
  /// Falls back to first of december in 1970 if parsing fails.
  static DateTime tryParseFirstOfDecemberInYear(String input) {
    return int.tryParse(input)?.let((v) => DateTime(v, 12)) ?? DateTime(1970, 12);
  }

  /// Expects a year as input and returns the second of december in that year.
  ///
  /// Falls back to second of december in 1970 if parsing fails.
  static DateTime parseSecondOfDecemberInYear(String input) {
    return int.tryParse(input)?.let((v) => DateTime(v, 12, 2)) ?? DateTime(1970, 12, 2);
  }

  /// Expects a ISO8601 formatted string as input and returns a DateTime.
  ///
  /// Falls back to 1970 if parsing fails.
  static DateTime parseISO8601(String input) {
    return DateTime.tryParse(input) ?? DateTime(1970);
  }
}

extension <T> on T {
  @pragma('vm:prefer-inline')
  R let<R>(R Function(T v) block) => block(this);
}
