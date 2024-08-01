import 'package:flutter/material.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class FadePainter extends CustomPainter {
  final List<SvgShapeModel> selectedShapes;
  final Animation<Color?> _color;

  FadePainter({
    required Animation<double> animation,
    required this.selectedShapes,
  })  : _color = ColorTween(
          begin: Colors.white,
          end: AppColors.shared.transparent,
        ).animate(animation),
        super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..saveLayer(null, Paint())
      ..drawColor(AppColors.shared.white, BlendMode.src);

    for (final shape in selectedShapes) {
      canvas.drawPath(
        shape.transformedPath,
        Paint()
          ..color = _color.value!
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
