import 'package:flutter/material.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class ShapePainter extends CustomPainter {
  ShapePainter({required this.shapes});

  final List<SvgShapeModel> shapes;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.clipRect(Offset.zero & size);
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
  bool shouldRepaint(ShapePainter oldDelegate) {
    return oldDelegate.shapes.where((e) => e.isPainted).length !=
        shapes.where((e) => e.isPainted).length;
  }
}
