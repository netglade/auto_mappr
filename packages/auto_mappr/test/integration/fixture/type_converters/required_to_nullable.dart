import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import '../type_converters.dart';
import 'required_to_nullable.auto_mappr.dart';

// Used to test the TypeConverter<Object, Object?> case
@AutoMappr(
  [
    // // Object -> Object?
    MapType<RequiredInput, NullableOutput>(),
  ],
  converters: [
    TypeConverter<String, Value<String>?>(RequiredToNullableConverterMappr.stringToNullableValueString),
  ],
)
class RequiredToNullableConverterMappr extends $RequiredToNullableConverterMappr {
  const RequiredToNullableConverterMappr();

  static Value<String>? stringToNullableValueString(String source) {
    return Value(source);
  }
}
