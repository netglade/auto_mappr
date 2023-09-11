import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';

class TypeConverter extends Equatable {
  final DartType source;
  final DartType target;
  final Expression? converter;

  @override
  List<Object?> get props => [source, target, converter];

  const TypeConverter({
    required this.source,
    required this.target,
    required this.converter,
  });
}
