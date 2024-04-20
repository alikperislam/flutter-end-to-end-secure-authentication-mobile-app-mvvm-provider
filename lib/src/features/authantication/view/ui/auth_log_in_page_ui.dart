import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/widgets/custom_snackbar_widget.dart';
import 'package:enguide_app/src/features/authantication/view/mixin/auth_log_in_page_mixin.dart';
import 'package:enguide_app/src/core/widgets/svg_widget.dart';
import 'package:enguide_app/src/features/authantication/view/widgets/auth_textfield_widget.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthLogInPageUi extends StatefulWidget {
  const AuthLogInPageUi({super.key});

  @override
  State<AuthLogInPageUi> createState() => _AuthLogInPageUiState();
}

class _AuthLogInPageUiState extends State<AuthLogInPageUi>
    with AuthLogInPageMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // svg image
        SvgImageWidget(
          top: 20,
          bottom: 0,
          left: 0,
          right: 0,
          image: ImageManager.signInSvgImage,
          width: 425,
          height: 425,
        ),
        // mail and password textfield
        const AuthTextFields(),
        // login button
        LogInButton(
          logInControllerFunction: logInControllerFunction,
        ),
      ],
    );
  }
}

class AuthTextFields extends StatelessWidget {
  const AuthTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          // mail
          TextFieldContainerWidget(
            top: 0,
            bottom: 20,
            icon: Icons.mail,
            hintText: LocaleKeys.mail.locale,
            controller: AuthLogInPageMixin.mailController,
            passwordLock: false,
            isMail: true,
          ),
          // password
          TextFieldContainerWidget(
            top: 0,
            bottom: 0,
            icon: Icons.lock,
            hintText: LocaleKeys.password.locale,
            controller: AuthLogInPageMixin.passwordController,
            passwordLock: true,
            isMail: false,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFieldContainerWidget extends StatelessWidget {
  double top;
  double bottom;
  IconData icon;
  String hintText;
  TextEditingController controller;
  bool passwordLock;
  bool isMail;
  TextFieldContainerWidget({
    super.key,
    required this.top,
    required this.bottom,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.passwordLock,
    required this.isMail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top.h,
        bottom: bottom.h,
      ),
      // textfield
      child: TextfieldWidget(
        controller: controller,
        hintText: hintText,
        icon: icon,
        passwordLock: passwordLock,
        height: 100,
        width: 735,
        fontSize: 33,
        fontColor: const Color.fromARGB(255, 158, 158, 158),
        fontWeight: FontWeight.w500,
        iconColor: ColorPalette.purpleColor,
        radius: 15,
        iconSize: 40,
        isMail: isMail,
        isLogin: true,
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  final String Function() logInControllerFunction;
  const LogInButton({required this.logInControllerFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(15.r),
          onTap: () {
            Scrollable.ensureVisible(context,
                alignment: 2.0); //! ust gorunume gec.
            //! gerekli kontroller tamamlanirsa login olsun.
            String ligInErrorText = logInControllerFunction();
            //! hata varsa hata mesajini widget ile goster.
            (ligInErrorText == '')
                ? null
                : CustomSnackBar.customSnackBar(
                    errorMessage: ligInErrorText,
                    contentType: ContentType.failure,
                    title: LocaleKeys.attention.locale,
                    context: context,
                  );
          },
          child: Ink(
            height: 100.h,
            width: 735.w,
            decoration: BoxDecoration(
              color: ColorPalette.purpleColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Center(
              child: Text(
                LocaleKeys.logInButton.locale,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
