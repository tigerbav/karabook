import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/checkbox/checkbox_cubit.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          BlocBuilder<CheckBoxCubit, bool>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: state
                      ? AppColors.shared.yellow
                      : AppColors.shared.transparent,
                  borderRadius: BorderRadius.circular(5.sp),
                  border:
                      Border.all(color: AppColors.shared.yellow, width: 1.sp),
                ),
                child: Icon(Icons.check, color: AppColors.shared.white),
              );
            },
          ),
          SizedBox(width: 10.sp),
          Text(title, style: AppStyles.shared.btnBlack),
        ],
      ),
    );
  }
}
