import 'package:enguide_app/src/features/authantication/provider/auth_login_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_verify_provider.dart';
import 'package:enguide_app/src/features/splash/provider/language_page_provider.dart';
import 'package:enguide_app/src/features/splash/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderList {
  // providers
  static List<SingleChildWidget> get multiProviders => [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguagePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthRegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthSigninProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthLoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthVerifyProvider(),
        ),
      ];
}
