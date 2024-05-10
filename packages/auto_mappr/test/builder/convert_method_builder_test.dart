import 'package:auto_mappr/src/builder/methods/convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/private_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/try_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/type_of_method_builder.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/run_zoned_auto_mappr.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/auto_mappr_options.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  test('buildConvertMethod has the correct interface', () {
    runZonedAutoMappr(() {
      final result = const ConvertMethodBuilder(
        AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
          mapprOptions: AutoMapprOptions(ignoreNullableSourceField: false, safeMapping: false),
        ),
      ).buildMethod();

      expect(result, isA<Method>());
      expect(result.name, equals('convert'));
      expect(result.types.length, equals(2));
      expect(result.returns, equals(result.types.elementAtOrNull(1)));
      expect(result.optionalParameters, isEmpty);
      expect(
        result.requiredParameters.toList(),
        equals([
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = result.types.firstOrNull?.nullabled(),
          ),
        ]),
      );
    });
  });

  test('buildTryConvertMethod has the correct interface', () {
    runZonedAutoMappr(() {
      final result = const TryConvertMethodBuilder(
        AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
          mapprOptions: AutoMapprOptions(ignoreNullableSourceField: false, safeMapping: false),
        ),
      ).buildMethod();

      expect(result, isA<Method>());
      expect(result.name, equals('tryConvert'));
      expect(result.types.length, equals(2));
      expect(result.returns, equals(result.types.elementAtOrNull(1)?.nullabled()));
      expect(
        result.optionalParameters.toList(),
        equals([
          Parameter(
            (p) => p
              ..name = 'onMappingError'
              ..named = true
              ..type = refer('void Function(Object error, StackTrace stackTrace, SOURCE? source)?'),
          ),
        ]),
      );
      expect(
        result.requiredParameters.toList(),
        equals([
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = result.types.firstOrNull?.nullabled(),
          ),
        ]),
      );
    });
  });

  test('buildInternalConvertMethod has the correct interface', () {
    runZonedAutoMappr(() {
      final result = const PrivateConvertMethodBuilder(
        AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
          mapprOptions: AutoMapprOptions(ignoreNullableSourceField: false, safeMapping: false),
        ),
      ).buildMethod();

      expect(result, isA<Method>());
      expect(result.name, equals('_convert'));
      expect(result.types.length, equals(2));
      expect(result.returns, equals(result.types.elementAtOrNull(1)?.nullabled()));
      expect(result.optionalParameters.isEmpty, isFalse);
      expect(
        result.requiredParameters.toList(),
        equals([
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = result.types.firstOrNull?.nullabled(),
          ),
        ]),
      );
    });
  });

  test('buildTypeOfHelperMethod has the correct interface', () {
    runZonedAutoMappr(() {
      final result = const TypeOfMethodBuilder(
        AutoMapprConfig(
          mappers: [],
          availableMappingsMacroId: 'test',
          mapprOptions: AutoMapprOptions(ignoreNullableSourceField: false, safeMapping: false),
        ),
      ).buildMethod();

      expect(result, isA<Method>());
      expect(result.name, equals('_typeOf'));
      expect(result.types.length, equals(1));
      expect(result.returns, equals(refer('Type')));
      expect(result.optionalParameters, isEmpty);
      expect(result.requiredParameters, isEmpty);
    });
  });
}
