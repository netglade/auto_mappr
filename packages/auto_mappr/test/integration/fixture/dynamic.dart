// ignore_for_file: avoid-dynamic

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'dynamic.auto_mappr.dart';

@AutoMappr([
  MapType<DynamicDto, Int>(converters: [DynamicConverter.dynamicToIntConverter]),
  MapType<Int, Dynamic>(converters: [DynamicConverter.intToDynamicConverter]),
  MapType<DynamicDto, Dynamic>(),
  MapType<DynamicNoConverter, IntNoConverter>(),
  MapType<IntNoConverter, DynamicNoConverter>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class Dynamic {
  final dynamic value;

  const Dynamic({this.value});
}

class DynamicDto {
  final dynamic value;

  const DynamicDto({this.value});
}

class Int {
  final int value;

  const Int({required this.value});
}

class DynamicNoConverter {
  final dynamic value;

  const DynamicNoConverter({this.value});
}

class IntNoConverter {
  final int value;

  const IntNoConverter({required this.value});
}

abstract final class DynamicConverter {
  static const intToDynamicConverter = TypeConverter(intToDynamic);
  static const dynamicToIntConverter = TypeConverter(dynamicToInt);

  static dynamic intToDynamic(int source) => source < 50 ? source : source.toString();

  // ignore: switch_on_type, should be ok
  static int dynamicToInt(dynamic source) => switch (source) {
    int() => source,
    String() => int.parse(source),
    _ => 0,
  };
}
