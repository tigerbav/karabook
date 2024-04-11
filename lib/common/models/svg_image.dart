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
  final String? subcategories;
  final int? complete;
  final Uint8List? screenProgress;

  factory SvgImage.fromJson(Map<String, dynamic> json) {
    return SvgImage(
      id: json["id"],
      imageParts: json["imageParts"],
      imageCategory: json["imageCategory"],
      height: json["height"],
      width: json["width"],
      subcategories: json["subCategories"],
      complete: json["complete"],
      screenProgress: json["screenProgress"],
    );
  }

  factory SvgImage.fromJsonApi(Map<String, dynamic> json) {
    return SvgImage(
      id: json["id"],
      imageParts: json["imageParts"],
      imageCategory: json["imageCategory"],
      height: json["height"],
      width: json["width"],
      subcategories: json["subCategories"],
      complete: json["complete"],
      screenProgress: Uint8List.fromList((json["screenProgress"]).codeUnits),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageParts": imageParts,
        "imageCategory": imageCategory,
        "height": height,
        "width": width,
        "subcategories": subcategories,
      };

  String get svgOnlyStroke {
    return imageParts.replaceAll(RegExp('"#.*?\\"'), '"#FFFFFF"');
  }

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
