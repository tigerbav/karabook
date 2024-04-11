import 'dart:convert';

import 'dart:typed_data';

class PainterProgressModel {
  static const table = 'SvgImage';

  final int id;
  String shapes;
  bool isCompleted; // 0 / 1
  Uint8List? screenProgress;
  PainterProgressModel._({
    required this.id,
    required this.shapes,
    required this.isCompleted,
    this.screenProgress,
  });

  factory PainterProgressModel.fromJsonString(String str) {
    final jsonData = json.decode(str) as Map<String, dynamic>;
    return PainterProgressModel.fromMap(jsonData);
  }

  factory PainterProgressModel.fromScratch({
    required int id,
    required String shapes,
    required bool isCompleted,
    Uint8List? screenProgress,
  }) {
    return PainterProgressModel._(
        id: id, shapes: shapes, isCompleted: isCompleted);
  }

  factory PainterProgressModel.fromMap(Map<String, dynamic> map) {
    return PainterProgressModel._(
        id: map['id'],
        shapes: map['shapes'] ?? "",
        isCompleted: map['complete'] == 1,
        screenProgress: map['screenProgress']);
  }

  String toJsonString(PainterProgressModel data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'shapes': shapes.toString(),
        'complete': isCompleted ? 1 : 0,
        'screenProgress': screenProgress
      };
}
