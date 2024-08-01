import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/events/presentation/logic/comics/comics_cubit.dart';
import 'package:karabookapp/pages/events/presentation/widgets/comics_list.dart';

class ComicsWidget extends StatelessWidget {
  const ComicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicsCubit, ComicsState>(
      buildWhen: (p, c) => p.packs != c.packs || p.isLoading != c.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.shared.pink),
          );
        }

        if (state.packs.isEmpty) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.sp),
              child: Text(
                LocaleKeys.comics.tr(),
                style: AppStyles.shared.h1,
              ),
            ),
            SizedBox(height: 20.sp),
            const ComicsList(),
          ],
        );
      },
    );
  }
}
