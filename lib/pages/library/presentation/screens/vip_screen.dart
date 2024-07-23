import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/pages/library/presentation/logic/vip/vip_cubit.dart';
import 'package:karabookapp/pages/library/presentation/widgets/library_banner.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
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
  late final PurchasesManager _purchasesManager;

  @override
  void initState() {
    super.initState();
    final id = context.read<VipCubit>().pack.nameKey ?? '';
    _purchasesManager = PurchasesManager();
    _purchasesManager.init(id);
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
                    : const LibraryBanner(),
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
                  PrimaryButton(
                    text: '\$39.9',
                    action: _purchasesManager.buy,
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
                  p.images != c.images || p.isLoading != c.isLoading,
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
                return ImagesGrid(state.images, heroTag: C.vip);
              },
            ),
          ],
        ),
      ),
    );
  }
}
