import 'package:code_builder/code_builder.dart';

extension ReferenceExtension on Reference {
  Reference get nullabled => refer('${this.accept(DartEmitter())}?');
}
