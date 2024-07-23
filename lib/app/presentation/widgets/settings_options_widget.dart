import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/enums/settings_type.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_styles.dart';

class SettingsOptionsWidget extends StatelessWidget {
  const SettingsOptionsWidget({super.key, required this.types});

  final List<SettingsType> types;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: types.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _Item(types[index]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this._type);

  final SettingsType _type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _type.doAction(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        color: AppColors.shared.transparent,
        child: Row(
          children: [
            SvgPicture.asset(
              _type.icon,
              width: 24.sp,
              height: 24.sp,
            ),
            SizedBox(width: 8.sp),
            Expanded(
              child: Text(_type.title, style: AppStyles.shared.settingsOption),
            ),
            if (_type.hasSwitch)
              IgnorePointer(
                child: SizedBox(
                  height: 16.sp,
                  child: Transform.scale(
                    scale: 0.8,
                    child: BlocBuilder<SettingsCubit, SettingsState>(
                      buildWhen: (p, c) =>
                          p.valueByOptionType(_type) !=
                          c.valueByOptionType(_type),
                      builder: (context, state) {
                        final value = state.valueByOptionType(_type);
                        if (value == null) return const SizedBox();

                        return CupertinoSwitch(
                          onChanged: null,
                          value: value,
                          thumbColor: value == true
                              ? AppColors.shared.purple
                              : AppColors.shared.black,
                          activeColor: AppColors.shared.lightGrey,
                          trackColor: AppColors.shared.darkGrey,
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
