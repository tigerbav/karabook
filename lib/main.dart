import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/app/presentation/logic/app/app_cubit.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/locale',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en', 'US'),
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AppCubit()),
            BlocProvider(create: (_) => SettingsCubit()),
          ],
          child: const App(),
        ),
      ),
    ),
  );
}
