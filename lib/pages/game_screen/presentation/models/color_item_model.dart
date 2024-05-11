import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorItemModel extends Equatable {
  const ColorItemModel({
    required this.color,
    required this.number,
    required this.maxItems,
    required this.completedItems,
  });

  final Color color;
  final int number;
  final int maxItems;
  final int completedItems;

  bool get isCompleted => maxItems <= completedItems;

  double get percent => 1 - completedItems / maxItems;

  ColorItemModel get incrementCompletedItems =>
      copyWith(completedItems: completedItems + 1);

  ColorItemModel copyWith({
    Color? color,
    int? number,
    int? maxItems,
    int? completedItems,
  }) {
    return ColorItemModel(
      color: color ?? this.color,
      number: number ?? this.number,
      maxItems: maxItems ?? this.maxItems,
      completedItems: completedItems ?? this.completedItems,
    );
  }

  @override
  List<Object?> get props => [color, number, maxItems, completedItems];
}
