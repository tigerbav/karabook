import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

class SvgLineModel {
  final String id;
  final String d;
  final String stroke;
  final double strokeWidth;
  final double? strokeMiterLimit;
  final String? strokeLineCap;
  final Paint paint;
  final Path _path;
  Path? transformedPath;
  SvgLineModel._(
    this.id,
    this.d,
    this.stroke,
    this.strokeWidth,
    this.strokeMiterLimit,
    this.strokeLineCap,
    this.paint,
  ) : _path = parseSvgPathData(d);

  factory SvgLineModel.fromElement(XmlElement svgElement) {
    // final strokeWidthAttr = svgElement.getAttribute('stroke-width');
    // final strokeMiterLimitAttr = svgElement.getAttribute('stroke-miterlimit');

    final paint = Paint()
      ..color = HexColor('#1A171B')
      ..strokeWidth = 0
      ..style = PaintingStyle.stroke
      ..strokeMiterLimit = 0
      ..strokeCap = StrokeCap.round;

    return SvgLineModel._(
      svgElement.getAttribute('id').toString(),
      svgElement.getAttribute('d').toString(),
      svgElement.getAttribute('stroke').toString(),
      paint.strokeWidth,
      paint.strokeMiterLimit,
      svgElement.getAttribute('stroke-linecap'),
      paint,
    );
  }

  /// transforms a [_path] into [transformedPath] using given [matrix]
  void transform(Matrix4 matrix) =>
      transformedPath = _path.transform(matrix.storage);
}
