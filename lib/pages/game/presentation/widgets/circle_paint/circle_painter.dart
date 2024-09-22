import 'package:flutter/material.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class CirclePainter extends CustomPainter {
  const CirclePainter({
    required this.radius,
    required this.selectedShape,
  });

  final SvgShapeModel selectedShape;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..clipPath(selectedShape.transformedPath)
      ..drawCircle(
        selectedShape.number,
        radius,
        Paint()
          ..color = selectedShape.fill
          ..style = PaintingStyle.fill,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
