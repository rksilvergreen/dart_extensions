import 'dart:typed_data';
import '../iterable/iterable_extensions.dart';
import 'package:convert/convert.dart';
import '../string/string_extensions.dart';

extension Uint8ListExtension on Uint8List {
  List<Uint8List> chunkedUint8List(int chunkSize) => this.chunked(chunkSize).map((e) => Uint8List.fromList(e)).toList();

  List<String> toHexList() => hex.encode(this).toString().toUpperCase().splitEvery(2);
}