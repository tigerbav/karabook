import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/pages/game/presentation/logic/color_picker/color_picker_cubit.dart';

import 'package:karabookapp/pages/game/presentation/models/color_item_model.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BlocBuilder<ColorPickerCubit, ColorPickerState>(
        buildWhen: (p, c) => p.activePickers != c.activePickers,
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: state.activePickers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 11),
            itemBuilder: (context, index) => _Item(state.activePickers[index]),
          );
        },
      ),
    );
  }

  static const duration = Duration(milliseconds: 700);
}

class _Item extends StatelessWidget {
  const _Item(this.model);
  final ColorItemModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorPickerCubit, ColorPickerState>(
      buildWhen: (p, c) => p.selected != c.selected,
      builder: (context, state) {
        final isSelected = state.selected == model;

        return GestureDetector(
          onTap: () => context.read<ColorPickerCubit>().selectColor(model),
          child: Stack(
            alignment: isSelected ? Alignment.topCenter : Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: model.color,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  model.number.toString(),
                  style: model.color.computeLuminance() <= 0.4
                      ? AppStyles.shared.btn
                      : AppStyles.shared.btnBlack,
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.only(top: 2.5),
                  width: 47.5,
                  height: 47.5,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: state.selected?.percent ?? 0,
                      end: state.selected?.percent ?? 0,
                    ),
                    duration: ColorPicker.duration,
                    curve: Curves.easeInOut,
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5,
                      color: _colorChecker,
                      backgroundColor: AppColors.shared.transparent,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Color get _colorChecker {
    final isNeedDarker = model.color.computeLuminance() >= 0.4;
    final hsl = HSLColor.fromColor(model.color);
    final lightnessValue = hsl.lightness + (isNeedDarker ? -.2 : .2);

    final hslDark = hsl.withLightness(lightnessValue.clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
