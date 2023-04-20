// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mappr.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

class $Mappr {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    return _convert(model);
  }

  TARGET _convert<SOURCE, TARGET>(SOURCE? model) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<Todo>() || sourceTypeOf == _typeOf<Todo?>()) &&
        (targetTypeOf == _typeOf<TodoItem>() ||
            targetTypeOf == _typeOf<TodoItem?>())) {
      return (_map_Todo_To_TodoItem((model as Todo?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  TodoItem _map_Todo_To_TodoItem(Todo? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Todo -> TodoItem failed because Todo was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Todo, TodoItem> to handle null values during mapping.');
    }
    return TodoItem(
      id: model.id,
      title: model.title,
    );
  }
}
