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

  FittedSizes getFittedSize(String svgString) {
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

  /// define lines and shapes
  void setLinesAndShapes({
    required String svgString,
    required List<SvgShapeModel> shapes,
    required List<SvgLineModel> lines,
    required FittedSizes fs,
  }) {
    final xmlElements = List<XmlElement>.from(
      XmlDocument.parse(svgString).findAllElements(GameConst.path),
    );

    final rect =
        Alignment.center.inscribe(fs.destination, Offset.zero & _canvasSize);
    final matrix = Matrix4.translationValues(rect.left, rect.top, 0)
      ..scale(fs.destination.width / fs.source.width);

    for (final e in xmlElements) {
      if (e.toString().contains(GameConst.fill)) {
        shapes.add(SvgShapeModel.fromElement(e, matrix));
      }
      if (e.toString().contains(GameConst.stroke)) {
        lines.add(SvgLineModel.fromElement(e)..transform(matrix));
      }
    }
  }

  /// sort list by colors
  Map<Color, List<SvgShapeModel>> setSortedShapes(List<SvgShapeModel> shapes) {
    final sortedShapes = <Color, List<SvgShapeModel>>{};
    final updatedShapes = <SvgShapeModel>[];

    for (final shape in shapes) {
      if (sortedShapes.containsKey(shape.fill)) {
        sortedShapes[shape.fill]?.add(shape);
      } else {
        sortedShapes[shape.fill] = [shape];
      }

      //TODO: [shapes] and [sortedShapes] have different numbers inside
      final newNumber = shape.number.copyWith(
        number: sortedShapes.keys.toList().indexOf(shape.fill),
      );
      updatedShapes.add(shape.copyWith(number: newNumber));
    }

    shapes.clear();
    shapes.addAll(updatedShapes);

    return sortedShapes;
  }

  static final _canvasSize = Size(1.sw, 1.sh * 0.85);
}
