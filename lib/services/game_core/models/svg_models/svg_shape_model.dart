import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:karabookapp/common/utils/extensions/string.dart';
import 'package:karabookapp/services/game_core/enums/number_move_type.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

class SvgShapeModel {
  SvgShapeModel({
    required this.id,
    required this.d,
    required this.fill,
    this.number = const PainterNumber(dx: 0, dy: 0, number: -1, size: 0),
    this.isPainted = false,
    required this.transformedPath,
  }) : path = parseSvgPathData(d);

  final int id;
  final String d;
  final Color fill;
  final Path path;
  final PainterNumber number;
  final bool isPainted;
  final Path transformedPath;

  factory SvgShapeModel.fromElement({
    required XmlElement svgElement,
    required Matrix4 matrix,
    required List<int> completedIds,
  }) {
    final id = int.tryParse(svgElement.getAttribute('id') ?? '-1') ?? -1;
    final d = svgElement.getAttribute('d').toString();

    final transformPath = parseSvgPathData(d).transform(matrix.storage);
    final hexColor = getHexColorFromAttrs(svgElement);
    var isPainted = hexColor == '#000000' || completedIds.contains(id);

    if (isPainted == false) {
      isPainted = autoFillSmallShapes(transformPath, completedIds);
    }

    return SvgShapeModel(
      id: id,
      d: svgElement.getAttribute('d').toString(),
      fill: HexColor(hexColor),
      isPainted: isPainted,
      transformedPath: transformPath,
      number: _defineNumber(
        transformPath,
        int.tryParse(svgElement.getAttribute('id') ?? '-1') ?? -1,
      ),
    );
  }

  static String getHexColorFromAttrs(XmlElement svgElement) {
    final attributeFill = svgElement.getAttribute('fill');
    final getHexColorFromStyle = attributeFill?.hexFromColorName ??
        attributeFill ??
        _getHexColorFromStyle(svgElement.getAttribute('style').toString());
    return getHexColorFromStyle;
  }

  static String _getHexColorFromStyle(String styleAttr) {
    final fillStyle =
        styleAttr.split(';').where((e) => e.contains('fill:')).first;
    final colorValue = fillStyle.replaceAll('fill:', '');

    return colorValue.hexFromColorName ?? colorValue;
  }

  /// auto fill a little parts of images
  static bool autoFillSmallShapes(
    Path transformedPath,
    List<int> completedIds,
  ) {
    final bounds = transformedPath.getBounds();

    final topLeftOffset = bounds.topLeft;
    final bottomRightOffset = bounds.bottomRight;
    int allPixels = 0;
    int allFilledPixels = 0;

    for (var x = topLeftOffset.dx; x <= bottomRightOffset.dx; x++) {
      for (var y = topLeftOffset.dy; y <= bottomRightOffset.dy; y++) {
        allPixels++;
        if (transformedPath.contains(Offset(x, y))) allFilledPixels++;
      }
    }
    if (allPixels <= 20) return true;
    return false;
  }

  static PainterNumber _defineNumber(Path transformedPath, int id) {
    final bounds = transformedPath.getBounds();
    final center = bounds.center;
    var currTxtSize = 19.0;
    var counter = 0;
    var maxCounter = 0;

    final height = bounds.bottom - bounds.top;
    final width = bounds.right - bounds.left;

    final heightStep = height / 6;
    final widthStep = width / 6;

    var position = const Offset(0, 0);
    const textSizeStep = 3;
    const minTextSize = 1;
    const maxPointsToCheck = 8;

    for (var ts = currTxtSize; ts >= minTextSize; ts -= textSizeStep) {
      for (final type in NumberMoveType.values) {
        final leftXOffset = type.leftX(center.dx, widthStep, ts);
        final topYOffset = type.topY(center.dy, heightStep, ts);
        final rightXOffset = type.rightX(center.dx, widthStep, ts);
        final bottomYOffset = type.bottomY(center.dy, heightStep, ts);

        final topLeft = Offset(leftXOffset, topYOffset);
        final topRight = Offset(rightXOffset, topYOffset);
        final bottomLeft = Offset(leftXOffset, bottomYOffset);
        final bottomRight = Offset(rightXOffset, bottomYOffset);

        final topMid = Offset(textSizeStep / 2 + leftXOffset, topYOffset);
        final rightMid = Offset(rightXOffset, textSizeStep / 2 + topYOffset);
        final bottomMid = Offset(textSizeStep / 2 + leftXOffset, bottomYOffset);
        final leftMid = Offset(leftXOffset, textSizeStep / 2 + topYOffset);

        if (transformedPath.contains(topLeft)) ++counter;
        if (transformedPath.contains(topRight)) ++counter;
        if (transformedPath.contains(bottomLeft)) ++counter;
        if (transformedPath.contains(bottomRight)) ++counter;

        if (transformedPath.contains(topMid)) ++counter;
        if (transformedPath.contains(rightMid)) ++counter;
        if (transformedPath.contains(bottomMid)) ++counter;
        if (transformedPath.contains(leftMid)) ++counter;

        if (maxCounter < counter ||
            (type == NumberMoveType.values.last && ts == minTextSize)) {
          maxCounter = counter;
          currTxtSize = ts;
          position = Offset(
            type.positionX(center.dx, widthStep),
            type.positionY(center.dy, heightStep),
          );
        }

        if (counter == maxPointsToCheck) {
          currTxtSize = ts;
          break;
        }

        counter = 0;
      }
      maxCounter = 0;

      if (counter == maxPointsToCheck) break;
    }

    return PainterNumber(dx: position.dx, dy: position.dy, size: currTxtSize);
  }

  SvgShapeModel copyWith({
    int? id,
    String? d,
    Color? fill,
    PainterNumber? number,
    bool? isPainted,
    Path? transformedPath,
  }) {
    return SvgShapeModel(
      id: id ?? this.id,
      d: d ?? this.d,
      fill: fill ?? this.fill,
      number: number ?? this.number,
      isPainted: isPainted ?? this.isPainted,
      transformedPath: transformedPath ?? this.transformedPath,
    );
  }
}

class PainterNumber extends Offset {
  const PainterNumber({
    required double dx,
    required double dy,
    this.number = -1,
    required this.size,
  }) : super(dx, dy);

  final int number;
  final double size;

  PainterNumber copyWith({
    int? number,
    double? size,
  }) {
    return PainterNumber(
      dx: super.dx,
      dy: super.dy,
      number: number ?? this.number,
      size: size ?? this.size,
    );
  }
}
