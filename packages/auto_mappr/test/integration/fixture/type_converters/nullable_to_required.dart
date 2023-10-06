import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import '../type_converters.dart';
import 'nullable_to_required.auto_mappr.dart';

// Used to test the TypeConverter<Object?, Object> case.
@AutoMappr(
  [
    // Object -> Object
    MapType<RequiredInput, RequiredOutput>(),
    // Object? -> Object
    MapType<NullableInput, RequiredOutput>(),
    // Object -> Object?
    MapType<RequiredInput, NullableOutput>(),
    // Object? -> Object?
    MapType<NullableInput, NullableOutput>(),
  ],
  converters: [
    TypeConverter<String?, Value<String>>(NullableToRequiredConverterMappr.nullableStringToValueString),
  ],
)
class NullableToRequiredConverterMappr extends $NullableToRequiredConverterMappr {
  const NullableToRequiredConverterMappr();

  static Value<String> nullableStringToValueString(String? source) {
    return Value(source ?? '');
  }
}
