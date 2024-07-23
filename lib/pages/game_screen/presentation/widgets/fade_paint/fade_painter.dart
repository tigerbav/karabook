import 'package:flutter/material.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class FadePainter extends CustomPainter {
  FadePainter({
    required this.selectedShapes,
  }) : super();

  final List<SvgShapeModel> selectedShapes;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..saveLayer(null, Paint())
      ..drawColor(AppColors.shared.white, BlendMode.src);

    for (final shape in selectedShapes) {
      canvas.drawPath(
        shape.transformedPath,
        Paint()
          ..color = shape.isPainted ? shape.fill : AppColors.shared.transparent
          ..blendMode = BlendMode.src
          ..style = PaintingStyle.fill,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
