import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/pages/game/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/pages/game/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game/presentation/logic/rewards/rewards_cubit.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class HelpButton extends StatefulWidget {
  final TransformationController transformationController;

  const HelpButton({
    required this.transformationController,
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
    return BlocBuilder<ColorPickerCubit, ColorPickerState>(
      buildWhen: (p, c) =>
          p.selected != c.selected || p.activePickers != c.activePickers,
      builder: (context, colorState) {
        if (colorState.selected == null) return const SizedBox();

        return BlocBuilder<GameCubit, GameState>(
          buildWhen: (p, c) => p.isCompleted != c.isCompleted,
          builder: (context, gameState) {
            if (gameState.isCompleted) return const SizedBox();

            return GestureDetector(
              onTap: () {
                final gameCubit = context.read<GameCubit>();
                final rewardCubit = context.read<RewardsCubit>();
                final settingCubit = context.read<SettingsCubit>();
                final colorPickerCubit = context.read<ColorPickerCubit>();

                // if (rewardCubit.state.noAds == false) {
                //   if (gameCubit.state.selectedShapes.isEmpty) {
                //     Utils.showToast(
                //       context,
                //       LocaleKeys.please_select_a_color.tr(),
                //       isError: false,
                //     );
                //   }
                //   if (rewardCubit.state.helpCount == 0) {
                //     rewardCubit.showRewardedAd(1);
                //     return;
                //   }
                // }

                for (final shape in gameCubit.state.selectedShapes) {
                  if (gameCubit.state.imageModel.completedIds
                          ?.contains(shape.id) ==
                      false) {
                    gameCubit.autoFill(
                      shape: shape,
                      autoFill: settingCubit.state.isFillHint,
                      pickerCubit: colorPickerCubit,
                    );
                    _animateHelpInitialize(shape);
                    if (rewardCubit.state.noAds == false) {
                      rewardCubit.increaseHelpCount();
                    }
                    break;
                  }
                }
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.shared.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.shared.yellow,
                        width: 2.sp,
                      ),
                    ),
                    height: 60.sp,
                    width: 60.sp,
                    child: SvgPicture.asset(AppResources.hints),
                  ),
                  BlocBuilder<RewardsCubit, RewardsState>(
                    buildWhen: (p, c) =>
                        p.helpCount != c.helpCount || p.noAds != c.noAds,
                    builder: (context, state) {
                      if (state.noAds) return const SizedBox();

                      return Positioned(
                        bottom: -5.sp,
                        left: -10.sp,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.shared.yellow,
                              width: 2.sp,
                            ),
                          ),
                          height: 30.sp,
                          width: 30.sp,
                          child: Text(
                            state.helpCount > 0
                                ? state.helpCount.toString()
                                : 'AD',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _animateHelpInitialize(SvgShapeModel shape) {
    _controllerReset?.reset();
    _animationReset = Matrix4Tween(
      begin: widget.transformationController.value,
      end: Matrix4Transform()
          .scale(C.maxZoom, origin: Offset(shape.number.dx, shape.number.dy))
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
