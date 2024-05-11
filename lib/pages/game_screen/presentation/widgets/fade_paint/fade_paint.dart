import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/fade_paint/fade_painter.dart';

class FadePaint extends StatefulWidget {
  const FadePaint({Key? key}) : super(key: key);

  @override
  State<FadePaint> createState() => _FadePaintState();
}

class _FadePaintState extends State<FadePaint> with TickerProviderStateMixin {
  late final AnimationController _fadeController;

  @override
  void initState() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BlocBuilder<GameCubit, GameState>(
        buildWhen: (p, c) => p.selectedShapes != c.selectedShapes,
        builder: (context, state) {
          return CustomPaint(
            painter: FadePainter(
              selectedShapes: state.selectedShapes,
            ),
          );
        },
      ),
    );
  }
}
