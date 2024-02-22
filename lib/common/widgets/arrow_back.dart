import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_resources.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.router.pop,
      child: Padding(
        padding: EdgeInsets.only(left: 20.sp),
        child: SvgPicture.asset(AppResources.back),
      ),
    );
  }
}
