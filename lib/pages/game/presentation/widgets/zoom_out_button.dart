import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/pages/game/presentation/logic/game/game_cubit.dart';

class ZoomOutButton extends StatefulWidget {
  final TransformationController transformController;

  const ZoomOutButton({required this.transformController, Key? key})
      : super(key: key);

  @override
  ZoomOutButtonState createState() => ZoomOutButtonState();
}

class ZoomOutButtonState extends State<ZoomOutButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controllerReset;
  Animation<Matrix4>? _animationReset;

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _controllerReset?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (p, c) => p.isCompleted != c.isCompleted,
      listener: (context, state) => animateResetInitialize(),
      buildWhen: (p, c) => p.isCompleted != c.isCompleted,
      builder: (context, state) {
        if (state.isCompleted) return const SizedBox();

        return IconButton(
          onPressed: animateResetInitialize,
          icon: SvgPicture.asset(AppResources.fullImage),
        );
      },
    );
  }

  void animateResetInitialize() {
    _controllerReset?.reset();
    _animationReset = Matrix4Tween(
      begin: widget.transformController.value,
      end: Matrix4.identity(),
    ).animate(_controllerReset!);
    _animationReset!.addListener(_onAnimateReset);
    _controllerReset?.forward();
  }

  void _onAnimateReset() {
    widget.transformController.value = _animationReset!.value;
    if (!_controllerReset!.isAnimating) {
      _animationReset!.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset?.reset();
    }
  }
}
