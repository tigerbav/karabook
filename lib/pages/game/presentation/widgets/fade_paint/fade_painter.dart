import 'package:flutter/material.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_shape_model.dart';

class FadePainter extends CustomPainter {
  final List<SvgShapeModel> selectedShapes;
  final Animation<double> animation;
  final _paint = Paint();

  FadePainter({
    required this.animation,
    required this.selectedShapes,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..saveLayer(null, Paint())
      ..drawColor(Colors.white, BlendMode.src);

    final color = ColorTween(
      begin: Colors.white,
      end: Colors.transparent,
    ).animate(animation);

    _paint
      ..color = color.value!
      ..blendMode = BlendMode.src
      ..style = PaintingStyle.fill;

    for (final shape in selectedShapes) {
      canvas.drawPath(shape.transformedPath!, _paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
