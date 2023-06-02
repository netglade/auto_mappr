import 'dart:typed_data';

import 'package:test/test.dart';

import '../fixture/regression/issue_77.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test(
    'Converts Uint8List to List<int> and vice-versa',
    () {
      final dto = fixture.Source(
        int8List: Uint8List.fromList([1, 2, 3]),
        int16List: Uint16List.fromList([1, 2, 3]),
        int32List: Uint32List.fromList([1, 2, 3]),
        int64List: Uint64List.fromList([1, 2, 3]),
        listData8: [1, 2, 3],
        listData16: [1, 2, 3],
        listData32: [1, 2, 3],
        listData64: [1, 2, 3],
      );
      final converted = mappr.convert<fixture.Source, fixture.Destination>(dto);

      expect(
        converted,
        fixture.Destination(
          int8List: [1, 2, 3],
          int16List: [1, 2, 3],
          int32List: [1, 2, 3],
          int64List: [1, 2, 3],
          listData8: Uint8List.fromList([1, 2, 3]),
          listData16: Uint16List.fromList([1, 2, 3]),
          listData32: Uint32List.fromList([1, 2, 3]),
          listData64: Uint64List.fromList([1, 2, 3]),
        ),
      );
    },
  );
}
