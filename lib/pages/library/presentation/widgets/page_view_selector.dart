import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/pages/library/presentation/logic/banner/banner_cubit.dart';

class PageViewSelector extends StatelessWidget {
  const PageViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      buildWhen: (p, c) => p.page != c.page || p.categories != c.categories,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(bottom: 10.sp),
          height: _size,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 9.sp),
            itemBuilder: (context, index) {
              final isActive = index == state.page;

              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.shared.transparent
                      : AppColors.shared.darkPurple,
                  border: isActive
                      ? Border.all(
                          width: 2.sp,
                          color: AppColors.shared.darkPurple,
                        )
                      : null,
                ),
                width: _size,
                height: _size,
              );
            },
          ),
        );
      },
    );
  }

  static final _size = 20.sp;
}
