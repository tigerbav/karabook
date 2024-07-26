import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/rewards/rewards_cubit.dart';

//TODO: need refactor
class RewardButton extends StatefulWidget {
  const RewardButton({Key? key}) : super(key: key);

  @override
  State<RewardButton> createState() => _RewardButtonState();
}

class _RewardButtonState extends State<RewardButton>
    with SingleTickerProviderStateMixin {
  static final _lowerBound = -100.0.sp;
  static final _upperBound = 20.0.sp;

  late final AnimationController _rewardController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: _lowerBound,
    upperBound: _upperBound,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            _rewardController.animateBack(_lowerBound);
          }
        });
      }
      if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 30), () {
          if (mounted) {
            _rewardController.forward(from: _lowerBound);
          }
        });
      }
    })
    ..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _rewardController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (mounted) {
          _rewardController.forward(from: _lowerBound);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (p, c) => p.isCompleted != c.isCompleted,
      builder: (context, state) {
        if (state.isCompleted) return const SizedBox();

        return Positioned(
          top: MediaQuery.of(context).padding.top + 100.sp,
          left: _rewardController.value,
          child: GestureDetector(
            onTap: () => context.read<RewardsCubit>().showRewardedAd(2),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.shared.yellow, width: 2.sp),
                  ),
                  height: 60.sp,
                  width: 60.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+2',
                        style: AppStyles.shared.btnBlack,
                      ),
                      SvgPicture.asset(AppResources.hints),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -5.sp,
                  right: -10.sp,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.shared.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.yellow, width: 2.sp),
                    ),
                    height: 30.sp,
                    width: 30.sp,
                    child: FittedBox(
                      child: Text(
                        'AD',
                        style: AppStyles.shared.btnBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
