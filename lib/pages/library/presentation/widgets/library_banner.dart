import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/widgets/loading_widget.dart';
import 'package:karabookapp/pages/library/presentation/logic/banner/banner_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/empty_banner.dart';
import 'package:karabookapp/pages/library/presentation/widgets/page_view_selector.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';

class LibraryBanner extends StatelessWidget {
  const LibraryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      buildWhen: (p, c) =>
          p.isLoading != c.isLoading || p.categories != c.categories,
      builder: (context, state) {
        if (state.isLoading) return const LoadingWidget();

        if (state.categories.isEmpty) return const EmptyBanner();

        return const Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _BannerPageView(),
            PageViewSelector(),
          ],
        );
      },
    );
  }
}

class _BannerPageView extends StatefulWidget {
  const _BannerPageView();

  @override
  State<_BannerPageView> createState() => _BannerPageViewState();
}

class _BannerPageViewState extends State<_BannerPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh * 0.21,
      child: BlocConsumer<BannerCubit, BannerState>(
        listenWhen: (p, c) => c.isTick,
        listener: (context, state) {
          if (state.page == 0) {
            _pageController.jumpToPage(state.page);
          } else {
            _pageController.animateToPage(
              state.page,
              duration: const Duration(seconds: 1),
              curve: Curves.linearToEaseOut,
            );
          }
        },
        buildWhen: (p, c) => p.categories != c.categories,
        builder: (context, state) {
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            onPageChanged: context.read<BannerCubit>().setPage,
            itemBuilder: (context, index) {
              return _Item(state.categories[index]);
            },
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.categoryModel);

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final preview = categoryModel.categoryPreview;
    if (preview == null) return const EmptyBanner();

    return GestureDetector(
      onTap: () => context.read<BannerCubit>().onTap(categoryModel, context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
          child: Image.memory(
            const Base64Decoder().convert(preview),
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}
