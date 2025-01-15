import 'package:auto_mappr/src/builder/map_bodies/map_bodies.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

/// Creates mapping body.
class MapModelBodyMethodBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final bool nullable;
  // ignore: prefer-typedefs-for-callbacks, private API
  final void Function(TypeMapping? mapping)? onUsedNullableMethodCallback;

  const MapModelBodyMethodBuilder({
    required this.mapperConfig,
    required this.mapping,
    this.onUsedNullableMethodCallback,
    this.nullable = false,
  });

  Code build() {
    final block = BlockBuilder();

    // Input as local model.
    block.statements.add(declareFinal('model').assign(refer('input')).statement);
    // Add handling of whenSourceIsNull.
    block.statements.add(_whenModelIsNullHandling());

    // Is there an enum involved in the mapping?
    final enumMapBodyBuilder = EnumBodyBuilder(
      mapperConfig: mapperConfig,
      mapping: mapping,
      onUsedNullableMethodCallback: onUsedNullableMethodCallback,
    );
    if (enumMapBodyBuilder.canProcess()) {
      block.statements.add(enumMapBodyBuilder.build());

      return block.build();
    }

    final classMapBodyBuilder = ClassBodyBuilder(
      mapperConfig: mapperConfig,
      mapping: mapping,
      onUsedNullableMethodCallback: onUsedNullableMethodCallback,
    );

    // Return a constructor call
    // optionally with cascaded setter assignments.
    block.statements.add(classMapBodyBuilder.build());

    return block.build();
  }

  Code _whenModelIsNullHandling() {
    final ifConditionExpression = refer('model').equalTo(literalNull);

    if (nullable) {
      final ifBodyExpression = mapping.hasWhenNullDefault() ? mapping.whenSourceIsNullExpression! : literalNull;

      // Generates code like:
      //
      // if (model == null) {
      //   return whenSourceIsNullExpression; // When whenSourceIsNullExpression is set.
      //   return null; // Otherwise.
      // }
      return ifConditionExpression.ifStatement2(ifBody: ifBodyExpression.returned.statement).code;
    }

    final ifBodyExpression = mapping.hasWhenNullDefault()
        ? mapping.whenSourceIsNullExpression!.returned
        : refer('Exception').newInstance([
            refer(
              "r'Mapping $mapping failed because ${mapping.source} was null, and no default value was provided. \n Consider setting the whenSourceIsNull parameter on the MapType<${mapping.source}, ${mapping.target}> to handle null values during mapping.'",
            ),
          ]).thrown;

    // Generates code like:
    //
    // if (model == null) {
    //   return whenSourceIsNullExpression; // When whenSourceIsNullExpression is set.
    //   throw Exception('Mapping UserDto -> User when null but no default value provided!'); // Otherwise.
    // }
    return ifConditionExpression.ifStatement2(ifBody: ifBodyExpression.statement).code;
  }
}
