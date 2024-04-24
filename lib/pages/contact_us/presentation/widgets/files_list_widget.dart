import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/pages/contact_us/presentation/logic/contact_us_cubit.dart';

class FilesListWidget extends StatelessWidget {
  const FilesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      buildWhen: (p, c) => p.files != c.files,
      builder: (context, state) {
        if (state.files.isEmpty) return const SizedBox();

        // Maybe, there is an other way
        return Container(
          margin: EdgeInsets.only(bottom: 20.sp),
          height: 100.sp,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 20.sp),
              SizedBox(
                height: 100.sp,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.files.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => SizedBox(width: 10.sp),
                  itemBuilder: (context, index) => _Item(state.files[index]),
                ),
              ),
              SizedBox(width: 20.sp),
            ],
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this._file);
  final File _file;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          _file,
          fit: BoxFit.scaleDown,
        ),
        Positioned(
          right: 5.sp,
          top: 5.sp,
          child: GestureDetector(
            onTap: () => context.read<ContactUsCubit>().deleteImage(_file),
            child: Container(
              padding: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.shared.darkPurple,
              ),
              child: SvgPicture.asset(AppResources.close),
            ),
          ),
        ),
      ],
    );
  }
}
