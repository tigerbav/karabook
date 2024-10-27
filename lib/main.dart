import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/app/data/datasources/setting_datasource.dart';
import 'package:karabookapp/app/domain/repositories/setting_repository.dart';
import 'package:karabookapp/app/presentation/logic/app/app_cubit.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/app/presentation/screens/app.dart';
import 'package:karabookapp/common/widgets/restart_widget.dart';
import 'package:karabookapp/generated/codegen_loader.g.dart';
import 'package:karabookapp/services/auth_service.dart';
import 'package:karabookapp/services/in_app_purchases/purchases_manager.dart';
import 'package:karabookapp/services/internet_cubit.dart';
import 'package:karabookapp/services/isar/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await IsarService.shared.setup();
  MobileAds.instance.initialize();
  AuthService().init();
  await PurchasesManager.shared.initPlatformState();

  runApp(
    RestartWidget(
      child: EasyLocalization(
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
              BlocProvider(create: (_) => InternetCubit()),
              BlocProvider(
                create: (_) => SettingsCubit(
                  SettingRepository(SettingDataSource()),
                ),
                lazy: false,
              ),
            ],
            child: const App(),
          ),
        ),
      ),
    ),
  );
}
