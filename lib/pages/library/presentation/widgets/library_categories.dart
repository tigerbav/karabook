import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';

class LibraryCategories extends StatefulWidget {
  const LibraryCategories({super.key});

  @override
  State<LibraryCategories> createState() => _LibraryCategoriesState();
}

class _LibraryCategoriesState extends State<LibraryCategories> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.sp,
      child: BlocBuilder<LibraryCubit, LibraryState>(
        buildWhen: (p, c) =>
            p.isLoadingCategories != c.isLoadingCategories ||
            p.currCategory != c.currCategory,
        builder: (context, state) {
          if (state.isLoadingCategories) {
            return Center(
              child: SizedBox(
                width: 24.sp,
                child: CircularProgressIndicator(color: AppColors.shared.pink),
              ),
            );
          }

          if (state.currCategory == null) {
            return Text(
              LocaleKeys.no_categories.tr(),
              textAlign: TextAlign.center,
              style: AppStyles.shared.toast,
            );
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            controller: _controller,
            shrinkWrap: true,
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.sp),
            itemBuilder: (context, index) => _Item(
              category: state.categories[index],
              isSelected: state.categories[index].id == state.currCategory?.id,
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.category,
    required this.isSelected,
  });
  final CategoryModel category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LibraryCubit>().setCurrentCategory(category.id),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.shared.purple,
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
              )
            : null,
        child: Text(
          category.name ?? LocaleKeys.oops.tr(),
          style: isSelected ? AppStyles.shared.segment : AppStyles.shared.toast,
        ),
      ),
    );
  }
}
