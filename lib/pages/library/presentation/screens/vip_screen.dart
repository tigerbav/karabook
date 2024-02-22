import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/models/svg_image.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';

@RoutePage()
class VipScreen extends StatelessWidget {
  const VipScreen({
    super.key,
    required this.packs,
    required this.images,
  });

  final Pack packs;
  final List<SvgImage> images;

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/images/pokemon.png',
                  fit: BoxFit.cover,
                ),
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
                      'Pokemon',
                      style: AppStyles.shared.packTitles,
                    ),
                  ),
                  PrimaryButton(
                    text: '\$39.9',
                    action: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Text(
                'Мы рады поделиться инкиальной историей созданной нашей талантилой художницей. В этом самом первом пакете картино вы можете п...  И бла-бла) Тянем всю страницу с сервака',
                style: AppStyles.shared.packDescription,
              ),
            ),
            SizedBox(height: 20.sp),
            ImagesGrid(images: images),
          ],
        ),
      ),
    );
  }
}
