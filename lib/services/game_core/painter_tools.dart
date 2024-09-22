import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';

import 'package:karabookapp/services/game_core/game_const.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/network/failures/failure.dart';
import 'package:xml/xml.dart';

class PainterTools {
  static PainterTools shared = PainterTools._();
  PainterTools._();

  /// define lines and shapes
  void setLinesAndShapes({
    required String svgString,
    required List<SvgShapeModel> shapes,
    required List<SvgLineModel> lines,
    required List<int> completedIds,
  }) {
    final fs = _getFittedSize(svgString);
    final xmlElements = List<XmlElement>.from(
      XmlDocument.parse(svgString).findAllElements(GameConst.path),
    );

    final rect =
        Alignment.center.inscribe(fs.destination, Offset.zero & _canvasSize);
    final matrix = Matrix4.translationValues(rect.left, rect.top, 0)
      ..scale(fs.destination.width / fs.source.width);

    for (final e in xmlElements) {
      if (e.toString().contains(GameConst.fill)) {
        shapes.add(SvgShapeModel.fromElement(
          svgElement: e,
          matrix: matrix,
          completedIds: completedIds,
        ));
      }
      if (e.toString().contains(GameConst.stroke)) {
        lines.add(SvgLineModel.fromElement(e)..transform(matrix));
      }
    }
  }

  /// sort list by colors
  Map<Color, List<SvgShapeModel>> setSortedShapes(List<SvgShapeModel> shapes) {
    var sortedShapes = <Color, List<SvgShapeModel>>{};

    for (final shape in shapes) {
      if (sortedShapes.containsKey(shape.fill)) {
        sortedShapes[shape.fill]?.add(shape);
      } else {
        sortedShapes[shape.fill] = [shape];
      }
    }

    sortedShapes = _sortBlackFirst(sortedShapes);

    return sortedShapes;
  }

  FittedSizes _getFittedSize(String svgString) {
    final xml = XmlDocument.parse(svgString);
    final xmlAttributes = xml.findElements('svg').firstOrNull?.attributes;

    final widthString = xmlAttributes
        ?.firstWhereOrNull((e) => e.name.toString() == GameConst.width)
        ?.value;

    final heightString = xmlAttributes
        ?.firstWhereOrNull((e) => e.name.toString() == GameConst.height)
        ?.value;

    if (widthString == null || heightString == null) {
      throw Failure('No width or height attributes in <svg>');
    }

    final width = double.tryParse(widthString);
    final height = double.tryParse(heightString);

    if (width == null || height == null) {
      throw Failure('Bad parsing of width or height attributes in <svg>');
    }

    final svgSize = Size(width, height);

    return applyBoxFit(BoxFit.contain, svgSize, _canvasSize);
  }

  /// first color should be black
  static Map<Color, List<SvgShapeModel>> _sortBlackFirst(
    Map<Color, List<SvgShapeModel>> unsortedShapes,
  ) {
    // Create a list of entries from the map
    final entries = unsortedShapes.entries.toList();

    // Define a custom sorting function
    entries.sort((a, b) {
      // Check if either entry has the color #000000
      final isABlack = a.key.value == 0xff000000;
      final isBBlack = b.key.value == 0xff000000;

      // If both colors are black, maintain their original order
      if (isABlack && isBBlack) return 0;

      // If 'a' is black, move it to the front
      if (isABlack) return -1;

      // If 'b' is black, move it to the front
      if (isBBlack) return 1;

      // Otherwise, maintain the original order
      return 0;
    });

    // Convert the sorted entries back to a map
    return Map.fromEntries(entries);
  }

  static final _canvasSize = Size(1.sw, 1.sh * 0.85);
}
