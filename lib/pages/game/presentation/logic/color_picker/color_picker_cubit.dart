import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/pages/game/presentation/models/color_item_model.dart';
import 'package:karabookapp/pages/game/presentation/widgets/color_picker.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';

part 'color_picker_state.dart';

class ColorPickerCubit extends Cubit<ColorPickerState> {
  ColorPickerCubit() : super(const ColorPickerState());

  void initColorPicker(Map<Color, List<SvgShapeModel>> sortedShapes) {
    final items = <ColorItemModel>[];
    var index = 0;

    for (final entry in sortedShapes.entries) {
      final paintedLength = entry.value.where((e) => e.isPainted).length;
      final maxItems = entry.value.length;

      items.add(ColorItemModel(
        color: entry.key,
        number: index++,
        maxItems: maxItems,
        completedItems: paintedLength,
        isCompleted: paintedLength >= maxItems,
      ));
    }

    emit(state.copyWith(items: items));
  }

  void selectColor(ColorItemModel model) {
    if (state.selected == model) {
      resetColor();
      return;
    }
    emit(state.copyWith(selected: model));
  }

  void resetColor() {
    emit(ColorPickerState(selected: null, items: state.items));
  }

  Future<void> incrementCompletedItem() async {
    final selected = state.selected;
    if (selected == null) return;
    final item = selected.incrementCompletedItems;
    final items = List<ColorItemModel>.from(state.items)
        .map((e) => e.number == selected.number ? item : e)
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
