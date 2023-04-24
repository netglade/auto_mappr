import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/extensions/reference_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test(
    'buildConvertMethod has the correct interface',
    () {
      final result = ConvertMethodBuilder(
        const AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
        ),
      ).buildConvertMethod();

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
    'buildTryConvertMethod has the correct interface',
    () {
      final result = ConvertMethodBuilder(
        const AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
        ),
      ).buildTryConvertMethod();

      expect(result, isA<Method>());
      expect(result.name, 'tryConvert');
      expect(result.types.length, 2);
      expect(result.returns, result.types[1].nullabled);
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
      final result = ConvertMethodBuilder(
        const AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
        ),
      ).buildInternalConvertMethod();

      expect(result, isA<Method>());
      expect(result.name, '_convert');
      expect(result.types.length, 2);
      expect(result.returns, result.types[1].nullabled);
      expect(result.optionalParameters.isEmpty, false);
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
      final result = ConvertMethodBuilder(
        const AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
        ),
      ).buildTypeOfHelperMethod();

      expect(result, isA<Method>());
      expect(result.name, '_typeOf');
      expect(result.types.length, 1);
      expect(result.returns, refer('Type'));
      expect(result.optionalParameters, isEmpty);
      expect(result.requiredParameters, isEmpty);
    },
  );
}
