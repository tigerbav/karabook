import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/circle_paint/circle_painter.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/color_picker.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

class ManyCirclesPaint extends StatelessWidget {
  const ManyCirclesPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingCubit = context.read<SettingsCubit>();

    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (p, c) => p.painted != c.painted,
      builder: (context, state) {
        final painted = state.painted;
        return Stack(
          children: [
            for (final shape in painted)
              SingleCirclePaint(
                shape: shape,
                onEndCircle: () {},
                millisecondsAnimation: settingCubit.state.isAnimation
                    ? ColorPicker.duration.inMilliseconds
                    : 0,
              ),
          ],
        );
      },
    );
  }
}

class SingleCirclePaint extends StatefulWidget {
  const SingleCirclePaint({
    required this.shape,
    required this.onEndCircle,
    required this.millisecondsAnimation,
    Key? key,
  }) : super(key: key);

  final SvgShapeModel shape;
  final VoidCallback onEndCircle;
  final int millisecondsAnimation;

  @override
  State<SingleCirclePaint> createState() => _SingleCirclePaintState();
}

class _SingleCirclePaintState extends State<SingleCirclePaint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.millisecondsAnimation),
      vsync: this,
    )
      ..addListener(_listener)
      ..forward().then((_) => widget.onEndCircle());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: CirclePainter(
          position: widget.shape.number,
          radius: _animationController.value *
              (widget.shape.transformedPath.getBounds().longestSide + 100),
          selectedShape: widget.shape,
        ),
      ),
    );
  }

  void _listener() => setState(() {});
}
