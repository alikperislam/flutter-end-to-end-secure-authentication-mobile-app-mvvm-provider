// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_verify_provider.dart';
import 'package:enguide_app/src/features/authantication/view/mixin/auth_verify_page_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:enguide_app/src/core/widgets/svg_widget.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';

class AuthVerifyPageUi extends StatefulWidget {
  const AuthVerifyPageUi({super.key});

  @override
  State<AuthVerifyPageUi> createState() => _AuthVerifyPageUiState();
}

class _AuthVerifyPageUiState extends State<AuthVerifyPageUi>
    with AuthVerifyPageMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // svg image
        svgImage(),
        // mail info (column)
        const MailDetailInfo(),
        // code field (row)
        CodeInputField(
          focusNodePinPut: focusNodePinPut,
          textController: textController,
        ),
        // send code again
        AgainButton(
          funcVerifyCodeSendMail: funcVerifyCodeSendMail,
        ),
        // verification check button
        VerifyButton(
          funcVerifyCodeController: funcVerifyCodeController,
        ),
        // number keyboard
        NumberKeys(
          funcPinputController: funcPinputController,
        ),
      ],
    );
  }

  Widget svgImage() {
    return SvgImageWidget(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      image: ImageManager.signInSvgImage,
      width: 425,
      height: 425,
    );
  }
}

class MailDetailInfo extends StatelessWidget {
  const MailDetailInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.h, bottom: 30.h),
      child: Column(
        children: [
          Consumer<AuthSigninProvider>(
            builder: (_, value, __) {
              return Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Text(
                  value.authSignInModel!.mailText!,
                  style: TextStyle(
                    color: ColorPalette.purpleColor,
                    fontSize: 35.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              LocaleKeys.verifyInfo.locale,
              style: TextStyle(
                color: ColorPalette.languageChooseTextColor,
                fontSize: 35.sp,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class CodeInputField extends StatelessWidget {
  FocusNode focusNodePinPut;
  TextEditingController textController;
  CodeInputField({
    required this.focusNodePinPut,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w, left: 5.w),
      child: SizedBox(
        width: 650.w,
        child: Pinput(
          autofocus: true,
          //? tiklanildiginda klavye acilmasin ama imlec acik kalsin.
          showCursor: true,
          readOnly: true,
          focusNode: focusNodePinPut,
          controller: textController,
          length: 6,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          defaultPinTheme: PinTheme(
            decoration: BoxDecoration(
              color: ColorPalette.lightPurpleColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            textStyle: TextStyle(
              color: ColorPalette.greyColor,
              fontSize: 45.sp,
            ),
            height: 100.r,
            width: 100.r,
          ),
          focusedPinTheme: PinTheme(
            decoration: BoxDecoration(
              color: ColorPalette.purpleBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            textStyle: TextStyle(
              color: ColorPalette.greyColor,
              fontSize: 45.sp,
            ),
            height: 100.r,
            width: 100.r,
          ),
          //! girdi tamamlaninca ve degisince data elimizde oluyor.
          onCompleted: (pin) =>
              context.read<AuthVerifyProvider>().setUserInputCode(pin),
          onChanged: (pin) =>
              context.read<AuthVerifyProvider>().setUserInputCode(pin),
        ),
      ),
    );
  }
}

class AgainButton extends StatelessWidget {
  Function funcVerifyCodeSendMail;
  AgainButton({
    required this.funcVerifyCodeSendMail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: ColorPalette.languageChooseTextColor,
      ),
      onPressed: () async {
        // Todo: tekrar mail gonder ve tiklanildiginda awesome_notification goster.
        funcVerifyCodeSendMail();
      },
      child: Text(
        LocaleKeys.verifyAgainButton.locale,
        style: TextStyle(
          color: ColorPalette.languageChooseTextColor,
          fontSize: 35.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

class VerifyButton extends StatelessWidget {
  Function funcVerifyCodeController;
  VerifyButton({
    required this.funcVerifyCodeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: () {
          // Todo: kod dogrulama kontrolu
          funcVerifyCodeController();
        },
        child: Ink(
          width: 650.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: ColorPalette.purpleColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              LocaleKeys.verifyButton.locale,
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumberKeys extends StatelessWidget {
  Function funcPinputController;
  NumberKeys({
    Key? key,
    required this.funcPinputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1 - 2 - 3
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberKey(
                keyData: 1,
                top: 30,
                bottom: 0,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 2,
                top: 30,
                bottom: 0,
                left: 25,
                right: 25,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 3,
                top: 30,
                bottom: 0,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
          ],
        ),
        // 4 - 5 - 6
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberKey(
                keyData: 4,
                top: 10,
                bottom: 10,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 5,
                top: 10,
                bottom: 10,
                left: 25,
                right: 25,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 6,
                top: 10,
                bottom: 10,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
          ],
        ),
        // 7 - 8 - 9
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberKey(
                keyData: 7,
                top: 0,
                bottom: 10,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 8,
                top: 0,
                bottom: 10,
                left: 25,
                right: 25,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 9,
                top: 0,
                bottom: 10,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
          ],
        ),
        // null - 0 - backIcon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberKey(
                keyData: null,
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: 0,
                top: 0,
                bottom: 0,
                left: 25,
                right: 25,
                funcPinputController: funcPinputController),
            NumberKey(
                keyData: Object(),
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                funcPinputController: funcPinputController),
          ],
        ),
      ],
    );
  }
}

class NumberKey extends StatelessWidget {
  Object? keyData;
  double top;
  double bottom;
  double left;
  double right;
  Function funcPinputController;

  NumberKey({
    Key? key,
    required this.keyData,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.funcPinputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((keyData != null)) {
      return Padding(
        padding: EdgeInsets.only(
            top: top.h, bottom: bottom.h, left: left.w, right: right.w),
        child: Material(
          child: InkWell(
            splashColor: const Color.fromARGB(255, 229, 222, 249),
            highlightColor: const Color.fromARGB(255, 240, 235, 254),
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              //! Butonlara basildiginda dogrulama kodunu girecek veya temizleyecek.
              funcPinputController(keyData);
            },
            child: Ink(
              height: 110.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: (keyData is num)
                    ? Text(
                        keyData.toString(),
                        style: TextStyle(
                          color: ColorPalette.lightPurpleColor,
                          fontSize: 50.sp,
                        ),
                      )
                    : const IconContent(),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 110.h,
        width: 200.w,
      );
    }
  }
}

class IconContent extends StatelessWidget {
  const IconContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.backspace_rounded,
      size: 50.r,
      color: ColorPalette.lightPurpleColor,
    );
  }
}
