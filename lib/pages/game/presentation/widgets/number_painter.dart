import 'package:flutter/material.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/utils/extensions/iterable.dart';
import 'package:karabookapp/pages/game/presentation/models/color_item_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class NumberPainter extends CustomPainter {
  NumberPainter({
    required this.shapes,
    required this.scale,
    required this.completedIds,
    required this.colors,
  });

  final List<SvgShapeModel> shapes;
  final double scale;
  final List<int> completedIds;
  final List<ColorItemModel> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );

    for (final shape in shapes) {
      final colorItem = colors.firstWhereOrNull((e) => e.color == shape.fill);
      final number = colorItem?.number ?? shape.number;

      final textStyle = TextStyle(
        color: AppColors.shared.darkBlue,
        fontSize: shape.number.size,
      );
      final textSpan = TextSpan(
        text: number.toString(),
        style: textStyle,
      );
      textPainter
        ..text = textSpan
        ..layout(
          minWidth: 0.5,
          maxWidth: 100,
        );
      if (completedIds.contains(shape.id) == false &&
          canShowByScale(shape) &&
          isShapeNotBlack(shape)) {
        textPainter.paint(
          canvas,
          Offset(
            shape.number.dx - shape.number.size / 2,
            shape.number.dy - shape.number.size / 2,
          ),
        );
      }
    }
  }

  bool canShowByScale(SvgShapeModel shape) {
    return scale > 0 && shape.number.size >= 16 && shape.number.size <= 25 ||
        scale > 1 && shape.number.size >= 10 && shape.number.size <= 16 ||
        scale > 2 && shape.number.size >= 8 && shape.number.size < 10 ||
        scale > 3 && shape.number.size >= 6 && shape.number.size < 8 ||
        scale > 4 && shape.number.size >= 5 && shape.number.size < 6 ||
        scale > 5 && shape.number.size >= 4 && shape.number.size < 5 ||
        scale > 7 && shape.number.size >= 1 && shape.number.size < 4;
  }

  bool isShapeNotBlack(SvgShapeModel shape) => shape.fill.value != 0xff000000;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
