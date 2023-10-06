import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import '../type_converters.dart';
import 'required_to_required.auto_mappr.dart';

// Used to test the TypeConverter<Object, Object> case.
@AutoMappr(
  [
    // Object -> Object
    MapType<RequiredInput, RequiredOutput>(),
    // Object -> Object?
    MapType<RequiredInput, NullableOutput>(),
  ],
  converters: [
    TypeConverter<String, Value<String>>(RequiredToRequiredConverterMappr.stringToValueString),
  ],
)
class RequiredToRequiredConverterMappr extends $RequiredToRequiredConverterMappr {
  const RequiredToRequiredConverterMappr();

  static Value<String> stringToValueString(String source) {
    return Value(source);
  }
}
