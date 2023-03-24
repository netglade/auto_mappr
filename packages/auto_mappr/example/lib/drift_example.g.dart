// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_example.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

class $Mappr {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    return _convert(model);
  }

  TARGET _convert<SOURCE, TARGET>(SOURCE? model) {
    if ((_typeOf<SOURCE>() == _typeOf<TodoCategory>() ||
            _typeOf<SOURCE>() == _typeOf<TodoCategory?>()) &&
        (_typeOf<TARGET>() == _typeOf<TodoCategoryTarget>() ||
            _typeOf<TARGET>() == _typeOf<TodoCategoryTarget?>())) {
      return (_mapTodoCategoryToTodoCategoryTarget((model as TodoCategory?))
          as TARGET);
    }
    throw Exception(
        'No mapping from ${model.runtimeType} -> ${_typeOf<TARGET>()}');
  }

  TodoCategoryTarget _mapTodoCategoryToTodoCategoryTarget(TodoCategory? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping TodoCategory -> TodoCategoryTarget when null but no default value provided!');
    }
    final result = TodoCategoryTarget(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
