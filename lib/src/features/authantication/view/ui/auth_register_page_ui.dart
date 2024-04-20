import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/features/authantication/view/mixin/auth_register_page_mixin.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_log_in_page_ui.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_sign_in_page_ui.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_verify_page_ui.dart';
import 'package:enguide_app/src/features/authantication/view/widgets/auth_base_widget.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AuthRegisterPageUi extends StatefulWidget {
  const AuthRegisterPageUi({super.key});

  @override
  State<AuthRegisterPageUi> createState() => _AuthRegisterPageUiState();
}

class _AuthRegisterPageUiState extends State<AuthRegisterPageUi>
    with AuthRegisterPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthRegisterProvider>(builder: (_, value, __) {
        return PopScope(
          canPop: !(value.verify), //? geri tusuna islev veriyor.
          onPopInvoked: (didPop) async {
            //! back tusuna basildiginda eger verify sayfasindaysa signin e don degilse avantajlara don.
            functionClickToBack();
            return;
          },
          child: Scaffold(
            backgroundColor: ColorPalette.greyBgColor,
            body: AuthBaseWidget(
              outsourceWidget: const AuthContent(),
            ),
          ),
        );
      }),
    );
  }
}

class AuthContent extends StatelessWidget {
  const AuthContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRegisterProvider>(builder: (_, value, __) {
      return Padding(
        padding: value.verify
            ? EdgeInsets.only(top: 0.h)
            : EdgeInsets.only(top: 102.5.h),
        child: Column(
          mainAxisAlignment:
              value.verify ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            // tab-bar(row - buttons)
            const TabBarComponent(),
            // relation widget(signIn-logIn)
            Consumer<AuthRegisterProvider>(
              builder: (_, value, __) {
                return value.page == true
                    ? const AuthLogInPageUi()
                    : value.verify == true
                        ? const AuthVerifyPageUi()
                        : const AuthSignInPageUi();
              },
            ),
          ],
        ),
      );
    });
  }
}

class TabBarComponent extends StatelessWidget {
  const TabBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // signin button
        Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(15.r),
            onTap: () {
              //!
              Scrollable.ensureVisible(context, alignment: 1.0);
              context.read<AuthRegisterProvider>().changePage(value: false);
            },
            child: Consumer<AuthRegisterProvider>(
              builder: (_, value, __) {
                return Visibility(
                  visible: !(value.verify),
                  child: Ink(
                    height: 60.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      color: value.page == true
                          ? ColorPalette.greyColor
                          : ColorPalette.purpleColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.signIn.locale,
                        style: TextStyle(
                          color: value.page == true
                              ? ColorPalette.purpleColor
                              : Colors.white,
                          fontSize: 33.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Consumer<AuthRegisterProvider>(
          builder: (_, value, __) {
            return Visibility(
              visible: !(value.verify),
              child: SizedBox(
                width: 15.w,
              ),
            );
          },
        ),
        // login button
        Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(15.r),
            onTap: () {
              //!
              Scrollable.ensureVisible(context, alignment: 1.0);
              // sayfa degisikligi
              context.read<AuthRegisterProvider>().changePage(value: true);
              // cinsiyet kismini temizle.
              context.read<AuthSigninProvider>().clearGender();
            },
            child: Consumer<AuthRegisterProvider>(
              builder: (_, value, __) {
                return Visibility(
                  visible: !(value.verify),
                  child: Ink(
                    height: 60.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      color: value.page == false
                          ? ColorPalette.greyColor
                          : ColorPalette.purpleColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.logIn.locale,
                        style: TextStyle(
                          color: value.page == false
                              ? ColorPalette.purpleColor
                              : Colors.white,
                          fontSize: 33.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
