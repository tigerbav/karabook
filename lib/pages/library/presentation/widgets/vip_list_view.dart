import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/models/pack.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/library/presentation/logic/library/library_cubit.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class VipListView extends StatefulWidget {
  const VipListView({super.key});

  @override
  State<VipListView> createState() => _VipListViewState();
}

class _VipListViewState extends State<VipListView> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.sp),
      controller: _controller,
      shrinkWrap: true,
      separatorBuilder: (_, __) => SizedBox(height: 24.sp),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Pokemon',
                    style: AppStyles.shared.packTitles,
                  ),
                ),
                PrimaryButton(
                  text: LocaleKeys.get_this_comic.tr(),
                  action: () {
                    context.router.navigate(
                      VipRoute(
                        packs: const Pack(
                          id: 0,
                          packName: '',
                          packIcon: '',
                          packDescription: '',
                          packsIdentifier: '',
                        ),
                        images: context.read<LibraryCubit>().state.images,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12.sp),
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                child: Image.asset(
                  'assets/images/pokemon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
