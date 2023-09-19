import 'dart:async';

import 'package:auto_mappr/src/helpers/emitter_helper.dart';

/// We need to use zones so we can easily have "scoped globals" for EmitterHelper.
// ignore: prefer-static-class, must be top level
R runZonedAutoMappr<R>(R Function() body, {Uri? libraryUri}) {
  return runZoned(
    () {
      return body();
    },
    zoneValues: {EmitterHelper.zoneSymbol: EmitterHelper(fileWithAnnotation: libraryUri)},
  );
}
