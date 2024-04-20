// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:enguide_app/src/core/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:enguide_app/src/core/widgets/svg_widget.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:enguide_app/src/features/authantication/view/mixin/auth_sign_in_page_mixin.dart';
import 'package:enguide_app/src/features/authantication/view/widgets/auth_textfield_widget.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AuthSignInPageUi extends StatefulWidget {
  const AuthSignInPageUi({super.key});

  @override
  State<AuthSignInPageUi> createState() => _AuthSignInPageUiState();
}

class _AuthSignInPageUiState extends State<AuthSignInPageUi>
    with AuthSignInPageMixin {
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
        // 5 textfield
        const AuthTextFields(),
        // row - gender buttons
        const GenderChoose(),
        // signin button
        SignInButton(signInControllerFunction: signInControllerFunction)
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
          // 5 textfield
          TextFieldContainerWidget(
            top: 0,
            bottom: 20,
            icon: Icons.person_2,
            hintText: LocaleKeys.nameSurname.locale,
            controller: AuthSignInPageMixin.nameController,
            passwordLock: false,
            isMail: false,
          ),
          // country search
          SearchFieldCountry(controller: AuthSignInPageMixin.countryController),
          TextFieldContainerWidget(
            top: 0,
            bottom: 20,
            icon: Icons.badge,
            hintText: LocaleKeys.job.locale,
            controller: AuthSignInPageMixin.jobController,
            passwordLock: false,
            isMail: false,
          ),

          TextFieldContainerWidget(
            top: 0,
            bottom: 20,
            icon: Icons.mail,
            hintText: LocaleKeys.mail.locale,
            controller: AuthSignInPageMixin.mailController,
            passwordLock: false,
            isMail: true,
          ),
          TextFieldContainerWidget(
            top: 0,
            bottom: 0,
            icon: Icons.lock,
            hintText: LocaleKeys.password.locale,
            controller: AuthSignInPageMixin.passwordController,
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
  late double top;
  late double bottom;
  late IconData icon;
  late String hintText;
  late TextEditingController controller;
  late bool passwordLock;
  late bool isMail;
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
        isLogin: false,
      ),
    );
  }
}

class SearchFieldCountry extends StatelessWidget {
  final TextEditingController controller;
  const SearchFieldCountry({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.h,
      ),
      child: Container(
        width: 735.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: ColorPalette.greyColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: // country search field
            SizedBox(
          width: 550.w,
          height: 80.h,
          child: SearchField(
            hint: LocaleKeys.country.locale,
            searchStyle: TextStyle(
              fontSize: 33.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              //? searchfield'a tiklanildiginda reverse ozelligini devreye al bu sayede sayfa ustte kalmayacak
              Scrollable.ensureVisible(context, alignment: 0.0);
            },
            //? field ile isimiz bittiginde sayfayi tekrardan ustten baslayarak goster.

            onTapOutside: (getEvent) {
              Scrollable.ensureVisible(context, alignment: 2.0);
              FocusScope.of(context).unfocus();
            },
            onSubmit: (x) {
              Scrollable.ensureVisible(context, alignment: 2.0);
            },
            searchInputDecoration: InputDecoration(
              // icerigin hizalanmasi.
              contentPadding: EdgeInsets.only(
                  left: 0.w, right: 30.w, top: 0.h, bottom: 0.h),
              hintStyle: TextStyle(
                fontSize: 33.sp,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
              isDense: true, // yaziyi ortalama
              prefixIcon: Icon(
                Icons.flag_rounded,
                size: 40.r,
                color: ColorPalette.purpleColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: ColorPalette.greyColor,
                  width: 0.r,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: ColorPalette.purpleColor,
                  width: 5.r,
                ),
              ),
            ),
            itemHeight: 100.h,
            maxSuggestionsInViewPort: 5,
            suggestionItemDecoration: const BoxDecoration(
              color: Colors.white,
            ),
            controller: controller,
            suggestions: LocaleKeys.countryList.locale
                .split(',')
                .toList()
                .map(
                  (x) => SearchFieldListItem(
                    x,
                    child: Center(
                      child: Text(
                        x,
                        style: TextStyle(
                            fontSize: 33.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class GenderChoose extends StatelessWidget {
  const GenderChoose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Consumer<AuthSigninProvider>(builder: (_, value, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // man gender button
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.r),
                  onTap: () {
                    Scrollable.ensureVisible(context, alignment: 2.0);
                    context.read<AuthSigninProvider>().clickGender(value: true);
                  },
                  child: Ink(
                    height: 100.h,
                    width: value.listBoolGender[0] == true
                        ? (value.listBoolGender[1] == true ? 325.h : 100.h)
                        : 100.h,
                    // eger secildiyse uzunlugu 120 yap secilmediyse 35!!!
                    decoration: BoxDecoration(
                      color: ColorPalette.greyColor,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        width: 5.w,
                        color: value.listBoolGender[0] == true
                            ? (value.listBoolGender[1] == true
                                ? ColorPalette.purpleColor
                                : ColorPalette.greyColor)
                            : ColorPalette.greyColor,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.male_rounded,
                        size: 60.r,
                        color: value.listBoolGender[0] == true
                            ? (value.listBoolGender[1] == true
                                ? ColorPalette.purpleColor
                                : Colors.grey)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              // woman gender button
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.r),
                  onTap: () {
                    Scrollable.ensureVisible(context, alignment: 2.0);
                    context
                        .read<AuthSigninProvider>()
                        .clickGender(value: false);
                  },
                  child: Ink(
                    height: 100.h,
                    width: value.listBoolGender[0] == true
                        ? (value.listBoolGender[1] == false ? 325.h : 100.h)
                        : 100.h,
                    decoration: BoxDecoration(
                      color: ColorPalette.greyColor,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        width: 5.w,
                        color: value.listBoolGender[0] == true
                            ? (value.listBoolGender[1] == false
                                ? ColorPalette.purpleColor
                                : ColorPalette.greyColor)
                            : ColorPalette.greyColor,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.female_sharp,
                          size: 60.r,
                          color: value.listBoolGender[0] == true
                              ? (value.listBoolGender[1] == false
                                  ? ColorPalette.purpleColor
                                  : Colors.grey)
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  final String Function(AuthSigninProvider authSigninProvider)
      signInControllerFunction;
  const SignInButton({required this.signInControllerFunction, super.key});

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
            //! textfieldlarin icerigi kontrol ediliyor. sorun bulunmazsa diger sayfaya aktarilacak.
            String signInErrorText =
                signInControllerFunction(context.read<AuthSigninProvider>());
            //! hata varsa hata mesajini widget ile goster.
            (signInErrorText == '')
                ? null
                : CustomSnackBar.customSnackBar(
                    errorMessage: signInErrorText,
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
                LocaleKeys.signInButton.locale,
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
