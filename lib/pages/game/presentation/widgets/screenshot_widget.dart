import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/game/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/pages/game/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game/presentation/widgets/line_paint/line_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/shape_painter.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotWidget extends StatelessWidget {
  const ScreenshotWidget({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    final pickerCubit = context.read<ColorPickerCubit>();

    return Screenshot(
      controller: gameCubit.screenshotController,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: GestureDetector(
              onTapUp: (details) async {
                final result = await gameCubit.paintTappedShape(
                  details,
                );

                if (result == false) return;
                pickerCubit.incrementCompletedItem();
              },
              child: BlocBuilder<GameCubit, GameState>(
                buildWhen: (p, c) => p.allShapes != c.allShapes,
                builder: (context, state) {
                  return RepaintBoundary(
                    child: CustomPaint(
                      isComplex: true,
                      painter: ShapePainter(shapes: state.allShapes),
                    ),
                  );
                },
              ),
            ),
          ),
          IgnorePointer(
            child: SizedBox(
              width: width,
              height: height,
              child: const LinePaint(),
            ),
          ),
        ],
      ),
    );
  }
}
