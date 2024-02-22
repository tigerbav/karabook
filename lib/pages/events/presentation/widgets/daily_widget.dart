import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/pages/events/presentation/widgets/daily_grid.dart';

class DailyWidget extends StatefulWidget {
  const DailyWidget({super.key});

  @override
  State<DailyWidget> createState() => _DailyWidgetState();
}

class _DailyWidgetState extends State<DailyWidget>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152.sp,
      child: BlocBuilder<DailyCubit, DailyState>(
        buildWhen: (p, c) => p.images != c.images || p.isLoading == c.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.shared.pink),
            );
          }

          if (state.images.isEmpty) {
            return Center(
              child: Text(LocaleKeys.soon.tr(), style: AppStyles.shared.h1),
            );
          }

          return ListView(
            controller: _scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: context.read<DailyCubit>().decreaseOpacity,
                child: Container(
                  padding: EdgeInsets.all(7.sp),
                  width: 152.sp,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.shared.pink),
                    borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                  ),
                  child: BlocBuilder<DailyCubit, DailyState>(
                    buildWhen: (p, c) =>
                        p.opacity != c.opacity || p.isGotGift != c.isGotGift,
                    builder: (context, state) {
                      return AnimatedOpacity(
                        onEnd: context.read<DailyCubit>().increaseOpacity,
                        opacity: state.opacity,
                        duration: const Duration(seconds: 2),
                        child: Image.asset(
                          state.isGotGift
                              ? 'assets/images/octopus.png'
                              : AppResources.dailyGift,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const DailyImage(),
            ],
          );
        },
      ),
    );
  }
}
