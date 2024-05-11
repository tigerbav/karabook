part of 'color_picker_cubit.dart';

class ColorPickerState extends Equatable {
  const ColorPickerState({
    this.items = const [],
    this.selected,
  });

  final List<ColorItemModel> items;
  final ColorItemModel? selected;

  List<ColorItemModel> get activePickers =>
      items.where((e) => e.isCompleted == false).toList();

  ColorPickerState copyWith({
    List<ColorItemModel>? items,
    ColorItemModel? selected,
  }) {
    return ColorPickerState(
      items: items ?? this.items,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [items, selected];
}
