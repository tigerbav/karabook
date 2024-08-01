import 'package:flutter/material.dart';

import 'svg_models/svg_shape_model.dart';

class ColoringShape {
  ColoringShape({required this.circlePosition, required this.shape});

  final Offset circlePosition;
  final SvgShapeModel shape;
}
