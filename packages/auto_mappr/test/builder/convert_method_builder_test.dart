import 'package:auto_mappr/builder/convert_method_builder.dart';
import 'package:auto_mappr/extensions/reference_extension.dart';
import 'package:auto_mappr/models/auto_mapper_config.dart';
import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test(
    'buildConvertMethod has the correct interface',
    () {
      final result = ConvertMethodBuilder.buildConvertMethod();

      expect(result, isA<Method>());
      expect(result.name, 'convert');
      expect(result.types.length, 2);
      expect(result.returns, result.types[1]);
      expect(result.optionalParameters, isEmpty);
      expect(result.requiredParameters, [
        Parameter(
          (p) => p
            ..name = 'model'
            ..type = result.types.first.nullabled,
        ),
      ]);
    },
  );

  test(
    'buildInternalConvertMethod has the correct interface',
    () {
      final result = ConvertMethodBuilder.buildInternalConvertMethod(const AutoMapprConfig(mappers: []));

      expect(result, isA<Method>());
      expect(result.name, '_convert');
      expect(result.types.length, 2);
      expect(result.returns, result.types[1]);
      expect(result.optionalParameters.length, 1);
      expect(result.optionalParameters.first.name, 'canReturnNull');
      expect(result.optionalParameters.first.type, refer('bool'));
      expect(result.requiredParameters, [
        Parameter(
          (p) => p
            ..name = 'model'
            ..type = result.types.first.nullabled,
        ),
      ]);
    },
  );

  test(
    'buildTypeOfHelperMethod has the correct interface',
    () {
      final result = ConvertMethodBuilder.buildTypeOfHelperMethod();

      expect(result, isA<Method>());
      expect(result.name, '_typeOf');
      expect(result.types.length, 1);
      expect(result.returns, refer('Type'));
      expect(result.optionalParameters, isEmpty);
      expect(result.requiredParameters, isEmpty);
    },
  );
}
