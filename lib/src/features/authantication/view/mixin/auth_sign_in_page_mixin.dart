// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enguide_app/src/core/errors/auth/auth_errors.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/widgets/custom_snackbar_widget.dart';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_sign_in_model.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_verify_provider.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_sign_in_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

mixin AuthSignInPageMixin on State<AuthSignInPageUi> {
  //? dependency injection
  AuthSignInModel? authSignInModel;
  AuthErrorModel? _signinPageErrorModel;

  //? textfield controllers
  static late TextEditingController nameController;
  static late TextEditingController countryController;
  static late TextEditingController jobController;
  static late TextEditingController mailController;
  static late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    //? sayfa ilk acildiginda nesne uretilecek.
    nameController = TextEditingController();
    countryController = TextEditingController();
    jobController = TextEditingController();
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    //? sayfa kapandiginda bellekteki tum controllerlar birakilacak.
    nameController.dispose();
    countryController.dispose();
    jobController.dispose();
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Todo: SignIn sayfasinda kayit ol butonuna basildiginda nesneyi olsutur ve gerekli kontrolleri sagla.
  String signInControllerFunction(AuthSigninProvider authSigninProvider) {
    _signinPageErrorModel = AuthErrorModel('');
    //! cinsiyet secildi mi kontrolu
    if (authSigninProvider.listBoolGender[1] == null) {
      _signinPageErrorModel!.setErrorFunction = LocaleKeys.pleaseGender.locale;
    } else {
      //? instance olusturuldu ilk olarak.
      createSignInModelInstance(
        genderValue: context.read<AuthSigninProvider>().listBoolGender[1]!,
      );
      //! Textfieldlarin icerikleri kontrol ediliyor.
      textFieldContentController();
    }
    return _signinPageErrorModel!.getErrorFunction;
  }

  // Todo: SignInModel turundeki instance'i olustur
  void createSignInModelInstance({required bool genderValue}) {
    authSignInModel = AuthSignInModel(
      nameText: AuthSignInPageMixin.nameController.text,
      countryText: AuthSignInPageMixin.countryController.text,
      jobText: AuthSignInPageMixin.jobController.text,
      mailText: AuthSignInPageMixin.mailController.text,
      passwordText: AuthSignInPageMixin.passwordController.text,
      gender: genderValue,
    );
  }

  // Todo: textfieldlarin iceriklerini kontrol et.
  textFieldContentController() async {
    //! kutucuklardan herhangi biri bos mu kontrolu
    if (authSignInModel!.nameText == '' ||
        authSignInModel!.countryText == '' ||
        authSignInModel!.jobText == '' ||
        authSignInModel!.mailText == '' ||
        authSignInModel!.passwordText == '') {
      _signinPageErrorModel!.setErrorFunction = LocaleKeys.pleaseFillIn.locale;
    }
    //! ad soyad girildi mi kontrolu
    else if (funcNameController() == false) {
      _signinPageErrorModel!.setErrorFunction = LocaleKeys.pleaseName.locale;
    }
    //! secilen ulke gecersiz bir ulke ismi mi kontrolu
    else if (LocaleKeys.countryList.locale
            .split(',')
            .toList()
            .contains(authSignInModel!.countryText) ==
        false) {
      _signinPageErrorModel!.setErrorFunction = LocaleKeys.pleaseCountry.locale;
    }
    //! mail adresi gecersiz mi kontrolu
    else if (EmailValidator.validate(authSignInModel!.mailText!) == false) {
      _signinPageErrorModel!.setErrorFunction = LocaleKeys.pleaseMail.locale;
    }
    //! parola uzunluk kontrolu
    else if (authSignInModel!.passwordText!.length < 6) {
      _signinPageErrorModel!.setErrorFunction =
          LocaleKeys.pleasePassword.locale;
    }
    //? textfield kontroller basarili ise:
    else {
      funcServerController();
    }
  }

  // Todo: fonksiyon icerisinde ad soyad bilgisi kontrol etme islemi.
  bool funcNameController() {
    if (authSignInModel!.nameText!.contains(' ') == true) {
      var listNameField = authSignInModel!.nameText!.split(' ').toList();
      listNameField.removeWhere((element) => element == '');
      if (listNameField.length >= 2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  funcServerController() async {
    bool internetCheck = await InternetConnectionChecker().hasConnection;
    if (internetCheck) {
      //? random dogrulama kodu olustur.
      context.read<AuthVerifyProvider>().randomCodeGenerator();
      //? kontrollerin ardindan authSignInModel intance'ini provider'da guncelliyoruz ve erisime aciliyor.
      context.read<AuthSigninProvider>().updateModel(authSignInModel!);
      //? mail gonderme islemi.
      await funcVerifyCodeSendMail();
    } else {
      //! internet baglanti uyarisi
      funcErrorInfo(LocaleKeys.internetCheck.locale);
    }
  }

  funcVerifyCodeSendMail() async {
    // Todo: mail gonderme islemi.
    await context
        .read<AuthVerifyProvider>()
        .funcPostMail(
          mailAddress: context
              .read<AuthSigninProvider>()
              .authSignInModel!
              .mailText
              .toString(),
          verifycode:
              context.read<AuthVerifyProvider>().getVerifyCode.toString(),
        )
        .then(
      (value) {
        //Todo: Sunucu ile baglanti kurulduysa diger sayfaya gec, degilse snackbar goster.
        (value == 200)
            ? controlSuccessful()
            : value == 409
                ? funcErrorInfo(LocaleKeys.userAvailable.locale)
                : funcErrorInfo(LocaleKeys.serverError.locale);
      },
    );
  }

  void controlSuccessful() {
    //? sayfa degisikligi icin tetikleme.
    context.read<AuthRegisterProvider>().changeVerify(value: true);
    //? butona basildiginda secili cinsiyet kismini temizle
    context.read<AuthSigninProvider>().clearGender();
  }

  funcErrorInfo(String message) {
    CustomSnackBar.customSnackBar(
      errorMessage: message,
      contentType: ContentType.failure,
      title: LocaleKeys.attention.locale,
      context: context,
    );
  }
}
