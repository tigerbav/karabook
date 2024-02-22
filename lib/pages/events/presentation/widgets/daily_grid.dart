import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';

class DailyImage extends StatefulWidget {
  const DailyImage({super.key});

  @override
  State<DailyImage> createState() => _DailyImageState();
}

class _DailyImageState extends State<DailyImage> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
      buildWhen: (p, c) => p.images != c.images,
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          shrinkWrap: true,
          controller: _controller,
          //daily image shouldn't be here
          itemCount: state.images.length - 1,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.sp,
            crossAxisSpacing: 12.sp,
          ),
          itemBuilder: (context, index) => _Item(
            image: state.images[index + 1],
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.image});
  final SvgImage image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.shared.grey),
            borderRadius: BorderRadius.all(Radius.circular(16.sp)),
          ),
          child: Image.asset(
            'assets/images/octopus.png',
            fit: BoxFit.contain,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 24.sp,
            padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 4.sp),
            decoration: BoxDecoration(
              color: AppColors.shared.darkPurple,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
              border: Border.all(color: AppColors.shared.purple),
            ),
            child: Text(
              '10',
              textAlign: TextAlign.center,
              style: AppStyles.shared.segment,
            ),
          ),
        ),
      ],
    );
  }
}
