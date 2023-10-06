import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import '../type_converters.dart';
import 'nullabe_to_nullable.auto_mappr.dart';

// Used to test the TypeConverter<Object?, Object?> case
@AutoMappr(
  [
    // Object -> Object?
    MapType<RequiredInput, NullableOutput>(),
    // Object? -> Object?
    MapType<NullableInput, NullableOutput>(),
  ],
  converters: [
    TypeConverter<String?, Value<String>?>(NullableToNullableConverterMappr.nullableStringToNullableValueString),
  ],
)
class NullableToNullableConverterMappr extends $NullableToNullableConverterMappr {
  const NullableToNullableConverterMappr();

  static Value<String>? nullableStringToNullableValueString(String? source) {
    return source != null ? Value(source) : null;
  }
}
