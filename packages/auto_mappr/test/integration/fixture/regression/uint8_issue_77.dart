import 'dart:typed_data';

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'uint8_issue_77.auto_mappr.dart';

class Source {
  final Uint8List int8List;
  final Uint16List int16List;
  final Uint32List int32List;
  final Uint64List int64List;
  final List<int> listData8;
  final List<int> listData16;
  final List<int> listData32;
  final List<int> listData64;

  const Source({
    required this.int8List,
    required this.int16List,
    required this.int32List,
    required this.int64List,
    required this.listData8,
    required this.listData16,
    required this.listData32,
    required this.listData64,
  });
}

class Destination with EquatableMixin {
  final List<int> int8List;
  final List<int> int16List;
  final List<int> int32List;
  final List<int> int64List;
  final Uint8List listData8;
  final Uint16List listData16;
  final Uint32List listData32;
  final Uint64List listData64;

  @override
  List<Object> get props {
    return [
      int8List,
      int16List,
      int32List,
      int64List,
      listData8,
      listData16,
      listData32,
      listData64,
    ];
  }

  const Destination({
    required this.int8List,
    required this.int16List,
    required this.int32List,
    required this.int64List,
    required this.listData8,
    required this.listData16,
    required this.listData32,
    required this.listData64,
  });
}

@AutoMappr([MapType<Source, Destination>()])
class Mappr extends $Mappr {
  const Mappr();
}
