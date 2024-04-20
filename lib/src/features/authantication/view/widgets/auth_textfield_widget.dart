import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_login_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TextfieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool passwordLock;
  final double height;
  final double width;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final Color iconColor;
  final double radius;
  final double iconSize;
  final bool isMail;
  final bool isLogin;

  const TextfieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.passwordLock,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.iconColor,
    required this.radius,
    required this.iconSize,
    required this.isMail,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: Consumer2<AuthLoginProvider, AuthSigninProvider>(
        builder: (_, valueLogin, valueSignin, __) {
          return TextField(
            controller: controller,
            autofocus: false,
            keyboardType:
                isMail ? TextInputType.emailAddress : TextInputType.text,
            onTap: () {
              //? textfield'a tiklanildiginda reverse ozelligini devreye al bu sayede sayfa ustte kalmayacak
              Scrollable.ensureVisible(context, alignment: 0.0);
            },
            //? field ile isimiz bittiginde sayfayi tekrardan ustten baslayarak goster.
            onTapOutside: (getEvent) {
              Scrollable.ensureVisible(context, alignment: 2.0);
              FocusScope.of(context).unfocus();
            },
            onSubmitted: (x) {
              Scrollable.ensureVisible(context, alignment: 2.0);
            },

            // content text
            style: TextStyle(
              fontSize: fontSize.sp,
              color: fontColor,
              fontWeight: fontWeight,
            ),
            textAlign: TextAlign.left, // yaziyi soldan baslatmak
            textAlignVertical: TextAlignVertical.center, // yaziyi ortalama
            // password lock
            obscureText: passwordLock
                ? isLogin
                    ? (valueLogin.passwordLockBool == true ? true : false)
                    : (valueSignin.passwordLockBool == true ? true : false)
                : false,
            decoration: InputDecoration(
              // left icon
              prefixIcon: Icon(
                icon,
                size: iconSize.r,
                color: iconColor,
              ),
              // password visible for right button
              suffixIcon: passwordLock
                  ? IconButton(
                      onPressed: () {
                        //login ise logIn provider'i tetikle degilse signIn provider'i tetikle.
                        isLogin
                            ? context.read<AuthLoginProvider>().changeLock()
                            : context.read<AuthSigninProvider>().changeLock();
                      },
                      icon: Icon(
                        //  icon degisecek.
                        isLogin
                            ? valueLogin.passwordLockBool == false
                                ? Icons.visibility
                                : Icons.visibility_off_rounded
                            : valueSignin.passwordLockBool == false
                                ? Icons.visibility
                                : Icons.visibility_off_rounded,
                        size: iconSize.r,
                        color: iconColor,
                      ),
                    )
                  : null,
              // hint text
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: fontSize.sp,
                color: fontColor,
                fontWeight: fontWeight,
              ),
              // bg colors
              filled: true,
              fillColor: ColorPalette.greyColor,
              contentPadding: EdgeInsets.only(right: 30.w),
              isDense: true, // yaziyi ortalama
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.purpleColor,
                  width: 5.r,
                ),
                borderRadius: BorderRadius.circular(radius.r),
              ),
              // non focus state
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.greyColor,
                  width: 0.r,
                ),
                borderRadius: BorderRadius.circular(radius.r),
              ),
            ),
          );
        },
      ),
    );
  }
}
