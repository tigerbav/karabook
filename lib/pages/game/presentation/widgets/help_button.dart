import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/core/rewards.dart';
import 'package:karabookapp/services/core/toast.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class HelpButton extends StatefulWidget {
  final TransformationController transformationController;
  final List<SvgShapeModel> selectedShapes;
  final Rewards rewards;

  const HelpButton({
    required this.transformationController,
    required this.selectedShapes,
    required this.rewards,
    Key? key,
  }) : super(key: key);

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controllerReset;
  Animation<Matrix4>? _animationReset;

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controllerReset?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.selectedShapes.isNotEmpty) {
          for (final shape in widget.selectedShapes) {
            if (!shape.isPainted) {
              if (helpCount > 0) {
                //Двигаемся к номеру
                _animateHelpInitialize(shape);
                //Уменьшаем счетчик помощи
                setState(() => --helpCount);
              } else {
                widget.rewards.showRewardedAd(() => setState(() {}));
              }
              break;
            }
          }
        } else {
          Toasts.showPickColorToast(context, 5);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.yellow, width: 2),
            ),
            height: 60,
            width: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/game_page/hints_icon.svg'),
                if (helpCount == 0)
                  const Text(
                    '+1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: -5,
            left: -10,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.yellow, width: 2),
              ),
              height: 30,
              width: 30,
              child: Text(
                helpCount > 0 ? helpCount.toString() : 'AD',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _animateHelpInitialize(SvgShapeModel shape) {
    _controllerReset?.reset();
    _animationReset = Matrix4Tween(
      begin: widget.transformationController.value,
      end: Matrix4Transform()
          .scale(15, origin: Offset(shape.number.dx, shape.number.dy))
          .matrix4,
    ).animate(_controllerReset!);
    _animationReset!.addListener(_onAnimateReset);
    _controllerReset?.forward();
  }

  void _onAnimateReset() {
    widget.transformationController.value = _animationReset!.value;
    if (!_controllerReset!.isAnimating) {
      _animationReset!.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset?.reset();
    }
  }
}
