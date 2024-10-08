import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/images_grid_item.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';

class DailyGrid extends StatefulWidget {
  const DailyGrid({super.key});

  @override
  State<DailyGrid> createState() => _DailyGridState();
}

class _DailyGridState extends State<DailyGrid> {
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
        final length = state.images.length > 7 ? 7 : state.images.length;
        return GridView.builder(
          shrinkWrap: true,
          //daily image shouldn't be here
          itemCount: length - 1,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.sp,
            crossAxisSpacing: 12.sp,
          ),
          itemBuilder: (context, index) => _Item(
            image: state.images[index + 1],
            day: (DateTime.now().toUtc().subtract(Duration(days: index + 1)))
                .day,
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.image, required this.day});
  final ImageModel image;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ImagesGridItem(
            image,
            heroTag: C.daily,
            updImage: () => ImageType.daily.updImage(
              context,
              image,
            ),
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
              day.toString(),
              textAlign: TextAlign.center,
              style: AppStyles.shared.segment,
            ),
          ),
        ),
      ],
    );
  }
}
