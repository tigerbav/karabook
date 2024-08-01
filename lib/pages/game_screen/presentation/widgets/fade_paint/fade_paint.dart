import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/fade_paint/fade_painter.dart';

class FadePaint extends StatefulWidget {
  const FadePaint(this._fadeController, {Key? key}) : super(key: key);
  final AnimationController _fadeController;

  @override
  State<FadePaint> createState() => _FadePaintState();
}

class _FadePaintState extends State<FadePaint> {
  @override
  void initState() {
    super.initState();
    widget._fadeController.addListener(_fadeControllerListener);
  }

  @override
  void dispose() {
    widget._fadeController.removeListener(_fadeControllerListener);
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
              animation: widget._fadeController,
            ),
          );
        },
      ),
    );
  }

  void _fadeControllerListener() => setState(() {});
}
