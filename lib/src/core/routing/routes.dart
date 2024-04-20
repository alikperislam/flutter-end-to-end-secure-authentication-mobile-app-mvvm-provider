import 'package:enguide_app/src/features/authantication/view/ui/auth_log_in_page_ui.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_sign_in_page_ui.dart';
import 'package:enguide_app/src/features/home/view/ui/home_page_ui.dart';
import 'package:enguide_app/src/features/splash/view/ui/language_choose_page_ui.dart';
import 'package:enguide_app/src/features/splash/view/ui/loading_page_ui.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_register_page_ui.dart';
import 'package:enguide_app/src/features/splash/view/ui/splash_screen_advantages_page_ui.dart';
import 'package:enguide_app/src/features/splash/view/ui/splash_screen_content_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  // ignore: no_leading_underscores_for_local_identifiers
  static route(BuildContext context, String _route) {
    switch (_route) {
      case ("/"):
        return const LoadingPageUi();
      case ("/languageChoose"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 0),
            child: const LanguageChoosePageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      case ("/splashScreenContent"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const SplashScreenContentPageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      case ("/splashScreenAdvantages"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const SplashScreenAdvtantagesPageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      case ("/authRegisterPageUi"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const AuthRegisterPageUi(),
            inheritTheme: true,
            ctx: context,
          ),
          // onceki tum sayfalari yok eder removeuntil ile beraber kullanilirsa.
          //(Route<dynamic> route) => false,
        );
      case ("/authSignInPageUi"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const AuthSignInPageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      case ("/authLogInPageUi"):
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const AuthLogInPageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      case "/homeHomePageUi":
        return Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const HomePageUi(),
            inheritTheme: true,
            ctx: context,
          ),
        );
    }
  }
}
