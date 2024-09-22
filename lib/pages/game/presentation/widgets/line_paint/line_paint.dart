import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/game/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game/presentation/widgets/line_paint/line_painter.dart';

class LinePaint extends StatelessWidget {
  const LinePaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (p, c) => p.svgLines != c.svgLines,
      builder: (context, state) {
        return RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            painter: LinePainter(lines: state.svgLines),
          ),
        );
      },
    );
  }
}
