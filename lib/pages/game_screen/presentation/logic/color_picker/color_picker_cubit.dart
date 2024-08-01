import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:karabookapp/pages/game_screen/presentation/models/color_item_model.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/color_picker.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

part 'color_picker_state.dart';

class ColorPickerCubit extends Cubit<ColorPickerState> {
  ColorPickerCubit({
    required Map<Color, List<SvgShapeModel>> sortedShapes,
  }) : super(const ColorPickerState()) {
    _calcPaintedColors(sortedShapes);
  }

  void _calcPaintedColors(Map<Color, List<SvgShapeModel>> sortedShapes) {
    final items = <ColorItemModel>[];
    var index = 0;

    for (final entry in sortedShapes.entries) {
      final paintedLength = entry.value.where((e) => e.isPainted).length;
      items.add(ColorItemModel(
        color: entry.key,
        number: index++,
        maxItems: entry.value.length,
        completedItems: paintedLength,
        isCompleted: entry.value.length <= paintedLength,
      ));
    }

    emit(state.copyWith(items: items));
  }

  void selectColor(ColorItemModel model) {
    //debugPrint('SHAPES: tapped color: ${model.toString()}');

    if (state.selected == model) {
      resetColor();
      return;
    }
    emit(state.copyWith(selected: model));
  }

  void resetColor() =>
      emit(ColorPickerState(selected: null, items: state.items));

  //not very good realization
  Future<void> incrementCompletedItem() async {
    final selected = state.selected;
    if (selected == null) return;
    final item = selected.incrementCompletedItems;
    final items = List<ColorItemModel>.from(state.items)
        .map((e) => e.number == selected.number ? e.incrementCompletedItems : e)
        .toList();

    emit(ColorPickerState(selected: item, items: items));

    if (item.maxItems <= item.completedItems) {
      await Future.delayed(ColorPicker.duration);
      final updItems = List<ColorItemModel>.from(state.items)
          .map((e) =>
              e.number == selected.number ? e.copyWith(isCompleted: true) : e)
          .toList();
      emit(ColorPickerState(items: updItems));
    }
  }
}
