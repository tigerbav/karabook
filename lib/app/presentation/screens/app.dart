import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/app/presentation/logic/app_cubit.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();
  static var lifecycleState = AppLifecycleState.resumed;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _router = AppRouter(App.navigatorKey);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    App.lifecycleState = state; // save actual state
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppSplash) {
          _router.replaceAll([const SplashRoute()]);
        } //
        else if (state is AppMenu) {
          _router.replaceAll([const TabBarRoute()]);
        }
      },
      child: MaterialApp.router(
        theme: ThemeData(
            // scaffoldBackgroundColor: AppColors.shared.mainBlueColor1,
            // unselectedWidgetColor: AppColors.shared.whiteColor,
            ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          ...context.localizationDelegates,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(
          navigatorObservers: () => [
            AutoRouteObserver(),
          ],
        ),
        builder: (context, child) => child ?? const SizedBox(),
      ),
    );
  }
}
