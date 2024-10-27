import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/pages/library/presentation/logic/vip/vip_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/empty_banner.dart';
import 'package:karabookapp/services/game_core/enums/image_type.dart';
import 'package:karabookapp/services/isar/models/category_model.dart';

@RoutePage()
class VipScreen extends StatelessWidget {
  const VipScreen({
    super.key,
    required this.pack,
  });

  final CategoryModel pack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => VipCubit(
        repository: LibraryRepository(LibraryDataSource()),
        pack: pack,
      ),
      child: const _VipScreen(),
    );
  }
}

class _VipScreen extends StatefulWidget {
  const _VipScreen();

  @override
  State<_VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<_VipScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VipCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          controller: _controller,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                child: cubit.pack.categoryPreview != null
                    ? Image.memory(
                        const Base64Decoder()
                            .convert(cubit.pack.categoryPreview!),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )
                    : const EmptyBanner(),
              ),
            ),
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cubit.pack.name ?? '',
                      style: AppStyles.shared.packTitles,
                    ),
                  ),
                  BlocBuilder<VipCubit, VipState>(
                    buildWhen: (p, c) =>
                        p.offering != c.offering ||
                        p.isLoading != c.isLoading ||
                        p.isAvailable != c.isAvailable,
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Center(
                          child: SizedBox(
                            width: 35.sp,
                            height: 35.sp,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: AppColors.shared.pink,
                              ),
                            ),
                          ),
                        );
                      }

                      return PrimaryButton(
                        text: state.isAvailable
                            ? LocaleKeys.acquired.tr()
                            : (state.offering?.lifetime?.storeProduct
                                    .priceString ??
                                LocaleKeys.oops.tr()),
                        action: context.read<VipCubit>().buy,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Text(
                cubit.pack.description ?? '',
                style: AppStyles.shared.packDescription,
              ),
            ),
            SizedBox(height: 20.sp),
            BlocBuilder<VipCubit, VipState>(
              buildWhen: (p, c) =>
                  p.visibleImages != c.visibleImages ||
                  p.isLoading != c.isLoading,
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: SizedBox(
                      width: 24.sp,
                      height: 24.sp,
                      child: CircularProgressIndicator(
                        color: AppColors.shared.pink,
                      ),
                    ),
                  );
                }
                return ImagesGrid(
                  state.visibleImages,
                  heroTag: C.vip,
                  imageType: ImageType.paidComics,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
