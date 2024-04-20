import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/widgets/svg_widget.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:enguide_app/src/core/routing/routes.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreenAdvtantagesPageUi extends StatelessWidget {
  const SplashScreenAdvtantagesPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorPalette.greyBgColor,
          body: Stack(
            children: [
              Column(
                children: [
                  const MetaLogo(),
                  SvgImageWidget(
                    top: 100,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    image: ImageManager.splash_image_2,
                    width: 700,
                    height: 700,
                  ),
                  const Header(),
                  const Content(),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NextButton(),
                  SplashField(),
                ],
              ),
            ],
          )),
    );
  }
}

// logo
class MetaLogo extends StatelessWidget {
  const MetaLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          ImageManager.purple_logo,
          width: 280.w,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, bottom: 0.h),
      child: Text(
        LocaleKeys.advantagePageTitle.locale,
        style: TextStyle(
          color: ColorPalette.textColorBlack,
          fontSize: 80.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 850.w,
      child: RichText(
        textAlign: TextAlign.center,
        softWrap: true,
        text: TextSpan(
          text: LocaleKeys.advantagePageContent.locale,
          style: TextStyle(
            color: ColorPalette.languageChooseTextColor,
            fontSize: 45.sp,
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: () {
        // signin login sayfasina gecis kodu
        context.read<AuthSigninProvider>().clearGender();
        Routes.route(context, "/authRegisterPageUi");
      },
      child: Ink(
        width: 450.w,
        height: 140.h,
        decoration: BoxDecoration(
          color: ColorPalette.purpleColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            LocaleKeys.startButtonTitle.locale,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class SplashField extends StatelessWidget {
  const SplashField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25.r,
            height: 25.r,
            decoration: BoxDecoration(
              color: ColorPalette.purpleColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Container(
            width: 180.w,
            height: 25.h,
            decoration: BoxDecoration(
              color: ColorPalette.purpleColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
        ],
      ),
    );
  }
}
