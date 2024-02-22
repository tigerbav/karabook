import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/pages/portfolio/presentation/enums/status_type.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';

class WorkStatus extends StatefulWidget {
  const WorkStatus({super.key});

  @override
  State<WorkStatus> createState() => _WorkStatusState();
}

class _WorkStatusState extends State<WorkStatus> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 24.sp,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        controller: _controller,
        shrinkWrap: true,
        itemCount: StatusType.values.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.sp),
        itemBuilder: (context, index) => _Item(StatusType.values[index]),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.statusType);

  final StatusType statusType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      buildWhen: (p, c) => p.statusType != c.statusType,
      builder: (context, state) {
        final isSelected = state.statusType == statusType;
        return GestureDetector(
          onTap: () => context.read<PortfolioCubit>().setStatusType(statusType),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 16.sp),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.shared.purple,
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  )
                : null,
            child: Text(
              statusType.title,
              style: isSelected
                  ? AppStyles.shared.segment
                  : AppStyles.shared.toast,
            ),
          ),
        );
      },
    );
  }
}
