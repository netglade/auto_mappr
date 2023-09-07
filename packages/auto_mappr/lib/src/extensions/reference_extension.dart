import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:code_builder/code_builder.dart';

extension ReferenceExtension on Reference {
  Reference get nullabled => refer('${accept(EmitterHelper.current.emitter)}?');
}
