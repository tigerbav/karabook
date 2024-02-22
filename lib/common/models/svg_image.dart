import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class SvgImage extends Equatable {
  const SvgImage({
    required this.id,
    required this.imageParts,
    required this.imageCategory,
    required this.height,
    required this.width,
    required this.subcategories,
    required this.complete,
    this.screenProgress,
  });

  final int id;
  final String imageParts;
  final String imageCategory;
  final int height;
  final int width;
  final String subcategories;
  final int? complete;
  final Uint8List? screenProgress;

  @override
  List<Object?> get props => [
        id,
        imageParts,
        imageCategory,
        height,
        width,
        subcategories,
        complete,
        screenProgress,
      ];
}
