import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/pages/app_tab_bar/presentation/enums/tab_bar_type.dart';
import 'package:lottie/lottie.dart';

class TabBarItem extends StatefulWidget {
  const TabBarItem({super.key, required this.type});

  final TabBarType type;

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    final isActive = context.tabsRouter.activeIndex == type.index;
    //TODO: bed realization: _checkAnimation shouldn't be in build
    _checkAnimation(isActive);

    return GestureDetector(
      onTap: () {
        if (isActive) {
          context.tabsRouter.stackRouterOfIndex(type.index)?.popUntilRoot();
        } else {
          context.tabsRouter.setActiveIndex(type.index);
        }
      },
      child: Lottie.asset(
        type.lottie,
        height: 70.sp,
        controller: _controller,
      ),
    );
  }

  void _checkAnimation(bool isActive) {
    isActive ? _controller.forward() : _controller.reverse();
  }
}
