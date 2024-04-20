import 'package:country_flags/country_flags.dart';
import 'package:enguide_app/src/core/enums/language_enums.dart';
import 'package:enguide_app/src/core/routing/routes.dart';
import 'package:enguide_app/src/features/splash/provider/language_page_provider.dart';
import 'package:enguide_app/src/features/splash/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:provider/provider.dart';

class LanguageChoosePageUi extends StatefulWidget {
  const LanguageChoosePageUi({super.key});

  @override
  State<LanguageChoosePageUi> createState() => _LanguageChoosePageUiState();
}

class _LanguageChoosePageUiState extends State<LanguageChoosePageUi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.greyBgColor,
        body: Stack(
          children: [
            // logo
            const MetaLogo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // text
                chooseText(),
                // language containerX2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 60,
                      rightSpace: 30,
                      leftSpace: 0,
                      flag_char: 'TR',
                      language: 'Türkçe',
                      languageEnum: LanguageEnum.tr,
                      index: 0,
                    ),
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 60,
                      rightSpace: 0,
                      leftSpace: 30,
                      flag_char: 'PT',
                      languageEnum: LanguageEnum.pt,
                      language: 'Português',
                      index: 1,
                    ),
                  ],
                ),
                // language containerX2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 60,
                      rightSpace: 30,
                      leftSpace: 0,
                      flag_char: 'RU',
                      language: 'Русский',
                      languageEnum: LanguageEnum.ru,
                      index: 2,
                    ),
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 60,
                      rightSpace: 0,
                      leftSpace: 30,
                      flag_char: 'DE',
                      language: 'Deutsch',
                      languageEnum: LanguageEnum.de,
                      index: 3,
                    ),
                  ],
                ),
                // language containerX2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 0,
                      rightSpace: 30,
                      leftSpace: 0,
                      flag_char: 'IT',
                      language: 'Italiano',
                      languageEnum: LanguageEnum.it,
                      index: 4,
                    ),
                    LanguageButton(
                      topSpace: 0,
                      bottomSpace: 0,
                      rightSpace: 0,
                      leftSpace: 30,
                      flag_char: 'ES',
                      language: 'Español',
                      languageEnum: LanguageEnum.es,
                      index: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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

// text
Widget chooseText() {
  return Padding(
    padding: EdgeInsets.only(bottom: 25.h),
    child: Text(
      "What is your native language?",
      style: TextStyle(
        color: ColorPalette.languageChooseTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 45.sp,
      ),
    ),
  );
}

// language choose buttons
// ignore: must_be_immutable
class LanguageButton extends StatelessWidget {
  double topSpace;
  double bottomSpace;
  double rightSpace;
  double leftSpace;
  // ignore: non_constant_identifier_names
  String flag_char;
  String language;
  LanguageEnum languageEnum;
  int index;
  LanguageButton({
    super.key,
    required this.topSpace,
    required this.bottomSpace,
    required this.rightSpace,
    required this.leftSpace,
    // ignore: non_constant_identifier_names
    required this.flag_char,
    required this.language,
    required this.languageEnum,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topSpace.h,
        bottom: bottomSpace.h,
        left: leftSpace.w,
        right: rightSpace.w,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(40.r),
        onTap: () {
          // secilen dil
          if (flag_char == "TR") {
            context.read<LanguagePageProvider>().chooseIndex(index);
          } else if (flag_char == "PT") {
            context.read<LanguagePageProvider>().chooseIndex(index);
          } else if (flag_char == "RU") {
            context.read<LanguagePageProvider>().chooseIndex(index);
          } else if (flag_char == "DE") {
            context.read<LanguagePageProvider>().chooseIndex(index);
          } else if (flag_char == "IT") {
            context.read<LanguagePageProvider>().chooseIndex(index);
          } else {
            context.read<LanguagePageProvider>().chooseIndex(index);
          }
        },
        child: Consumer<LanguagePageProvider>(
          builder: (context, value, child) {
            return Ink(
              width: 350.w,
              height: 380.h,
              decoration: BoxDecoration(
                color: ColorPalette.languageButtonColor,
                borderRadius: BorderRadius.circular(40.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5.r,
                    blurRadius: 5.r,
                    offset: const Offset(1, 3),
                  ),
                ],
                border: Border.all(
                  width: 5.w,
                  color: value.chooseLangList[index]
                      ? ColorPalette.purpleColor
                      : Colors.white,
                ),
              ),
              child: ButtonContent(
                flag_char: flag_char,
                language: language,
                languageEnum: languageEnum,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class ButtonContent extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String flag_char;
  String language;
  LanguageEnum languageEnum;
  int index;
  ButtonContent({
    super.key,
    // ignore: non_constant_identifier_names
    required this.flag_char,
    required this.language,
    required this.languageEnum,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // flag
        CountryFlag.fromCountryCode(
          flag_char,
          height: 90.h,
          width: 90.w,
          borderRadius: 0.r,
        ),
        SizedBox(
          height: 5.h,
        ),
        // language text
        Text(
          language,
          style: TextStyle(
            color: ColorPalette.languageChooseTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 45.sp,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        SizedBox(
          height: 5.h,
        ),
        // next button
        Consumer<LanguagePageProvider>(
          builder: (context, value, child) {
            return value.chooseLangList[index] == true
                ? NextButton(
                    language: language,
                    languageEnum: languageEnum,
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class NextButton extends StatelessWidget {
  String language;
  LanguageEnum languageEnum;
  NextButton({
    super.key,
    required this.language,
    required this.languageEnum,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: () {
        //? secilen dil provider sinifinda easy localization'i guncelliyor ve uygulama o dilde devam ediyor.
        context.read<LanguageProvider>().languageChoose(languageEnum, context);
        Routes.route(context, "/splashScreenContent");
      },
      child: Ink(
        width: 90.r,
        height: 90.r,
        decoration: BoxDecoration(
          color: ColorPalette.purpleColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5.r,
              blurRadius: 5.r,
              offset: Offset(1.w, 3.h),
            ),
          ],
        ),
        child: Icon(
          Icons.navigate_next,
          color: Colors.white,
          size: 60.r,
        ),
      ),
    );
  }
}
