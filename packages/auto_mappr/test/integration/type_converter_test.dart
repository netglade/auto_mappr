import 'package:test/test.dart';

import 'fixture/type_converter.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test('use most specific type converter', () {
    final dto = fixture.DateDto(
      dateTimeA: '2023',
      dateTimeB: '2023',
      dateTimeC: '2023-05-02T14:44:51.510',
    );
    final dto2 = fixture.DateDto2(
      dateTimeA: '2023-05-02T14:44:51.510',
      dateTimeB: '2023-05-02T14:44:51.510',
    );
    final domain1 = mappr.convert<fixture.DateDto, fixture.DateDomain>(dto);
    final domain2 = mappr.convert<fixture.DateDto2, fixture.DateDomain>(dto2);

    // defined on field level
    expect(domain1.dateTimeA, fixture.Mappr.tryParseFirstOfDecemberInYear(dto.dateTimeA));

    // defined on type level
    expect(domain1.dateTimeB, fixture.Mappr.parseSecondOfDecemberInYear(dto.dateTimeB));
    expect(domain1.dateTimeC, fixture.Mappr.parseSecondOfDecemberInYear(dto.dateTimeC));

    // defined on mappr level
    expect(domain2.dateTimeA, fixture.Mappr.parseISO8601(dto2.dateTimeA));
    expect(domain2.dateTimeB, fixture.Mappr.parseISO8601(dto2.dateTimeB));
  });

  test('nullable input type with non-nullable type converter input', () {
    final userDto = fixture.UserDto('userId', 'accountId');
    final user = mappr.convert<fixture.UserDto, fixture.User>(userDto);

    expect(user.id, const fixture.UserId('userId'));
    expect(user.accountId, const fixture.AccountId('accountId'));
  });
}
