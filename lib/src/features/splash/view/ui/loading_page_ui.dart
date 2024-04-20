import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:enguide_app/src/features/home/view/ui/home_page_ui.dart';
import 'package:enguide_app/src/features/splash/view/mixin/loading_page_mixin.dart';
import 'package:enguide_app/src/features/splash/view/ui/language_choose_page_ui.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPageUi extends StatefulWidget {
  const LoadingPageUi({Key? key}) : super(key: key);

  @override
  State<LoadingPageUi> createState() => _LoadingPageUiState();
}

class _LoadingPageUiState extends State<LoadingPageUi> with LoadingPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.purpleBgColor,
        body: animatedSplash(initializeData()),
      ),
    );
  }

  Widget animatedSplash(Future<String?> initializeData) {
    return FutureBuilder<String?>(
      future: initializeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        } else {
          return AnimatedSplashScreen(
            backgroundColor: ColorPalette.purpleBgColor,
            splash: Image.asset(
              ImageManager.lottie_logo_animation,
              width: 600.w,
            ),
            nextScreen: snapshot.data != null && snapshot.data != ''
                ? const HomePageUi()
                : const LanguageChoosePageUi(),
          );
        }
      },
    );
  }
}
