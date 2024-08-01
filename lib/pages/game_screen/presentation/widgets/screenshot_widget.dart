import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/line_paint/line_paint.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/shape_painter.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotWidget extends StatelessWidget {
  const ScreenshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    final pickerCubit = context.read<ColorPickerCubit>();

    return Screenshot(
      controller: gameCubit.screenshotController,
      child: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: GestureDetector(
              onTapUp: (details) async {
                final result = await gameCubit.paintTappedShape(
                  details,
                );

                if (result == false) return;
                pickerCubit.incrementCompletedItem();
              },
              child: BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  return RepaintBoundary(
                    child: CustomPaint(
                      isComplex: true,
                      painter: ShapePainter(
                        shapes: state.allShapes,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          IgnorePointer(
            child: SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: LinePaint(svgLines: gameCubit.svgLines),
            ),
          ),
        ],
      ),
    );
  }
}
