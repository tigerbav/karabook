import 'package:flutter/material.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/checkers_paint/checkers_painter.dart';

class CheckersPaint extends StatelessWidget {
  const CheckersPaint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: CheckersPainter(),
      ),
    );
  }
}
