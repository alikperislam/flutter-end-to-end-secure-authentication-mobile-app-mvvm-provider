import 'package:easy_localization/easy_localization.dart';
import 'package:enguide_app/src/core/constants/app_constants.dart';
import 'package:enguide_app/src/core/init/cache/auth/splash_token_hive.dart';
import 'package:enguide_app/src/core/init/localization/language.dart';
import 'package:enguide_app/src/core/locator/provider_locator.dart';
import 'package:enguide_app/src/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  // localization
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // hive cache
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(SplashTokenHiveDbAdapter());
  // ortam degiskenleri icin
  await dotenv.load(fileName: 'lib/assets/.env');
  // ekranin donmesini engelle
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        fallbackLocale: LanguageManager.instance.trLocale,
        path: LANG_ASSET_PATH,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        // providers
        return MultiProvider(
          providers: ProviderList.multiProviders,
          child: MaterialApp(
            // localization
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            // routing
            home: Routes.route(context, "/"),
          ),
        );
      },
    );
  }
}
