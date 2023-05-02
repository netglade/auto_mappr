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

abstract class ValueId<T> extends Equatable {
  final T value;

  @override
  List<Object?> get props => [value];

  const ValueId(this.value);

  static T toValue<T>(ValueId<T> id) => id.value;

  static String toValueString(ValueId<String> id) => id.value;
}

class UserId extends ValueId<String> {
  static const defaultUserId = UserId('defaultUserId');

  const UserId(super.value);

  static UserId? newNullable(String? value) => value == null ? null : UserId(value);
}

class AccountId extends ValueId<String> {
  const AccountId(super.value);

  static AccountId? newNullable(String? value) => value == null ? null : AccountId(value);
}

class User {
  final UserId id;
  final AccountId? accountId;

  const User(this.id, this.accountId);
}

class UserDto {
  final String? id;
  final String? accountId;

  const UserDto(this.id, this.accountId);
}

@AutoMappr(
  [
    MapType<DateDto, DateDomain>(
      fields: [
        Field(
          'dateTimeA',
          type: Mappr.tryParseFirstOfDecemberInYear,
        ),
      ],
      types: [
        Mappr.parseSecondOfDecemberInYear,
      ],
    ),
    MapType<DateDto2, DateDomain>(),
    MapType<UserDto, User>(
      fields: [
        Field('id', type: UserId.newNullable, whenNull: UserId.defaultUserId),
      ],
    ),
    MapType<User, UserDto>(),
  ],
  types: [
    Mappr.parseISO8601,
    UserId.new,
    AccountId.new,
    // This doesn't work currently, maybe analyzer bug?
    ValueId.toValue<String>,
    ValueId.toValueString,
  ],
)
class Mappr extends $Mappr {
  /// Expects a year as input and returns the first of december in that year.
  ///
  /// Falls back to first of december in 1970 if parsing fails.
  static DateTime tryParseFirstOfDecemberInYear(String input) {
    return DateTime(int.tryParse(input) ?? 1970, 12);
  }

  /// Expects a year as input and returns the second of december in that year.
  ///
  /// Falls back to second of december in 1970 if parsing fails.
  static DateTime parseSecondOfDecemberInYear(String input) {
    return DateTime(int.tryParse(input) ?? 1970, 12, 2);
  }

  /// Expects a ISO8601 formatted string as input and returns a DateTime.
  ///
  /// Falls back to 1970 if parsing fails.
  static DateTime parseISO8601(String input) {
    return DateTime.tryParse(input) ?? DateTime(1970);
  }
}
