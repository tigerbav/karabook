import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/app/presentation/logic/app_cubit.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppResources.welcomeImage,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.sp),
                child: Lottie.asset(
                  AppResources.welcomeLottie,
                  controller: _controller,
                  repeat: false,
                  onLoaded: (composition) => _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(context.read<AppCubit>().setMenu),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
