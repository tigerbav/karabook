enum NumberMoveType {
  center,
  top,
  bottom,
  right,
  left,
  topRight,
  bottomRight,
  bottomLeft,
  topLeft,
  topMiddle,
  bottomMiddle,
  rightMiddle,
  leftMiddle,
  topRightMiddle,
  bottomRightMiddle,
  bottomLeftMiddle,
  topLeftMiddle,
}

extension NumberMoveTypeEx on NumberMoveType {
  double leftX(double dx, double distance, double currTxtSize) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.top:
      case NumberMoveType.bottom:
      case NumberMoveType.topMiddle:
      case NumberMoveType.bottomMiddle:
        return dx - currTxtSize / 2;
      case NumberMoveType.right:
      case NumberMoveType.topRight:
      case NumberMoveType.bottomRight:
        return dx + distance * 2 - currTxtSize / 2;
      case NumberMoveType.left:
      case NumberMoveType.bottomLeft:
      case NumberMoveType.topLeft:
        return dx - distance * 2 - currTxtSize / 2;
      case NumberMoveType.rightMiddle:
      case NumberMoveType.topRightMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dx + distance - currTxtSize / 2;
      case NumberMoveType.leftMiddle:
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.topLeftMiddle:
        return dx - distance - currTxtSize / 2;
    }
  }

  double topY(double dy, double distance, double currTxtSize) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.right:
      case NumberMoveType.left:
      case NumberMoveType.rightMiddle:
      case NumberMoveType.leftMiddle:
        return dy - currTxtSize / 2;
      case NumberMoveType.top:
      case NumberMoveType.topLeft:
      case NumberMoveType.topRight:
        return dy - distance * 2 - currTxtSize / 2;
      case NumberMoveType.bottom:
      case NumberMoveType.bottomRight:
      case NumberMoveType.bottomLeft:
        return dy + distance * 2 - currTxtSize / 2;
      case NumberMoveType.topMiddle:
      case NumberMoveType.topLeftMiddle:
      case NumberMoveType.topRightMiddle:
        return dy - distance - currTxtSize / 2;
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.bottomMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dy + distance - currTxtSize / 2;
    }
  }

  double rightX(double dx, double distance, double currTxtSize) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.top:
      case NumberMoveType.bottom:
      case NumberMoveType.topMiddle:
      case NumberMoveType.bottomMiddle:
        return dx + currTxtSize / 2;
      case NumberMoveType.right:
      case NumberMoveType.topRight:
      case NumberMoveType.bottomRight:
        return dx + distance * 2 + currTxtSize / 2;
      case NumberMoveType.left:
      case NumberMoveType.bottomLeft:
      case NumberMoveType.topLeft:
        return dx - distance * 2 + currTxtSize / 2;
      case NumberMoveType.rightMiddle:
      case NumberMoveType.topRightMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dx + distance + currTxtSize / 2;
      case NumberMoveType.leftMiddle:
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.topLeftMiddle:
        return dx - distance + currTxtSize / 2;
    }
  }

  double bottomY(double dy, double distance, double currTxtSize) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.right:
      case NumberMoveType.left:
      case NumberMoveType.rightMiddle:
      case NumberMoveType.leftMiddle:
        return dy + currTxtSize / 2;
      case NumberMoveType.top:
      case NumberMoveType.topLeft:
      case NumberMoveType.topRight:
        return dy - distance * 2 + currTxtSize / 2;
      case NumberMoveType.bottom:
      case NumberMoveType.bottomRight:
      case NumberMoveType.bottomLeft:
        return dy + distance * 2 + currTxtSize / 2;
      case NumberMoveType.topMiddle:
      case NumberMoveType.topLeftMiddle:
      case NumberMoveType.topRightMiddle:
        return dy - distance + currTxtSize / 2;
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.bottomMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dy + distance + currTxtSize / 2;
    }
  }

  double positionX(double dx, double distance) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.top:
      case NumberMoveType.bottom:
      case NumberMoveType.topMiddle:
      case NumberMoveType.bottomMiddle:
        return dx;
      case NumberMoveType.right:
      case NumberMoveType.topRight:
      case NumberMoveType.bottomRight:
        return dx + distance * 2;
      case NumberMoveType.left:
      case NumberMoveType.bottomLeft:
      case NumberMoveType.topLeft:
        return dx - distance * 2;
      case NumberMoveType.rightMiddle:
      case NumberMoveType.topRightMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dx + distance;
      case NumberMoveType.leftMiddle:
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.topLeftMiddle:
        return dx - distance;
    }
  }

  double positionY(double dy, double distance) {
    switch (this) {
      case NumberMoveType.center:
      case NumberMoveType.right:
      case NumberMoveType.left:
      case NumberMoveType.rightMiddle:
      case NumberMoveType.leftMiddle:
        return dy;
      case NumberMoveType.top:
      case NumberMoveType.topLeft:
      case NumberMoveType.topRight:
        return dy - distance * 2;
      case NumberMoveType.bottom:
      case NumberMoveType.bottomRight:
      case NumberMoveType.bottomLeft:
        return dy + distance * 2;
      case NumberMoveType.topMiddle:
      case NumberMoveType.topLeftMiddle:
      case NumberMoveType.topRightMiddle:
        return dy - distance;
      case NumberMoveType.bottomLeftMiddle:
      case NumberMoveType.bottomMiddle:
      case NumberMoveType.bottomRightMiddle:
        return dy + distance;
    }
  }
}
