import 'package:flutter/material.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class ShapePainter extends CustomPainter {
  final List<SvgShapeModel> shapes;

  ShapePainter({
    required this.shapes,
  }) : super(repaint: null);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final paint = Paint();

    for (final shape in shapes) {
      final path = shape.transformedPath;
      if (shape.isPainted) {
        paint
          ..color = shape.fill
          ..style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
