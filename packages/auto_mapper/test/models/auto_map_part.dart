import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/builder/convert_method_builder.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _ATest extends Mock implements DartType {}

class _BTest extends Mock implements DartType {}

void main() {
  late DartEmitter emitter;

  setUp(() {
    emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);
  });

  group(
    'buildConvertMethod',
    () {
      test(
        'has the correct interface',
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
                ..type = result.types.first,
            ),
          ]);
        },
      );
    },
  );
}
