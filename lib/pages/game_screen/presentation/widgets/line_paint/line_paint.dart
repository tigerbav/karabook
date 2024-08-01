import 'package:flutter/material.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/line_paint/line_painter.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';

class LinePaint extends StatelessWidget {
  final List<SvgLineModel> svgLines;
  const LinePaint({
    required this.svgLines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: LinePainter(lines: svgLines),
      ),
    );
  }
}
