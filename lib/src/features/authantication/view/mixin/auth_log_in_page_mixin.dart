// ignore_for_file: use_build_context_synchronously
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enguide_app/src/core/errors/auth/auth_errors.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/routing/routes.dart';
import 'package:enguide_app/src/core/widgets/custom_snackbar_widget.dart';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_log_in_model.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_login_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_log_in_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

mixin AuthLogInPageMixin on State<AuthLogInPageUi> {
  AuthLogInModel? logInModel;
  AuthErrorModel? _logInPageErrorModel;
  // controller create
  static late TextEditingController mailController;
  static late TextEditingController passwordController;

  // auth_log_in_page_ui.dart initstate function
  @override
  void initState() {
    super.initState();
    // sayfa ilk acildiginda nesne uretilecek.
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // auth_log_in_page_ui.dart dispose function
  @override
  void dispose() {
    // sayfa kapandiginda bellekteki tum controllerlar birakilacak.
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Todo: login surecinin tum kontrollerini baslat
  String logInControllerFunction() {
    _logInPageErrorModel = AuthErrorModel('');
    createLogInModelInstance(); //? instance olustur.
    textFieldContentController(); //? textfieldlarda istenmeyen durum kontrolu yap.
    //! istenmeyen bir durum varsa kullaniciya bildirim ile donus yap.
    return _logInPageErrorModel!.getErrorFunction;
  }

  // Todo: kullanicinin girislerine gore instance olustur.
  createLogInModelInstance() {
    logInModel = AuthLogInModel(
      mailText: AuthLogInPageMixin.mailController.text,
      passwordText: AuthLogInPageMixin.passwordController.text,
    );
  }

  // Todo: textfieldlarin iceriklerini kontrol et.
  textFieldContentController() async {
    //? kutucuklardan herhangi biri bos mu kontrolu
    if (logInModel!.mailText == '' || logInModel!.passwordText == '') {
      _logInPageErrorModel!.setErrorFunction = LocaleKeys.pleaseFillIn.locale;
    }
    //? mail adresi gecersiz mi kontrolu
    else if (EmailValidator.validate(logInModel!.mailText!) == false) {
      _logInPageErrorModel!.setErrorFunction = LocaleKeys.pleaseMail.locale;
    }
    //? parola uzunluk kontrolu
    else if (logInModel!.passwordText!.length < 6) {
      _logInPageErrorModel!.setErrorFunction = LocaleKeys.pleasePassword.locale;
    }
    //? textfield kontroller basarili ise:
    else {
      funcServerController();
    }
  }

  // Todo: internet baglanti kontrolu yap ve provideri guncelle.
  funcServerController() async {
    bool internetCheck = await InternetConnectionChecker().hasConnection;
    if (internetCheck) {
      //? kontrollerin ardindan logInModel intance'ini provider'da guncelliyoruz ve erisime aciliyor.
      context.read<AuthLoginProvider>().updateModel(logInModel!);
      //? server'a login olma islemini baslat.
      await funcPostLogin();
    } else {
      //? internet baglanti uyarisi
      funcErrorInfo(LocaleKeys.internetCheck.locale);
    }
  }

  // Todo: servis baglanti islemlerini yap.
  funcPostLogin() async {
    // Todo: mail gonderme islemi.
    await context.read<AuthLoginProvider>().funcPostLogIn().then(
      (value) {
        //Todo: Sunucu ile baglanti kurulduysa diger sayfaya gec, degilse snackbar goster.
        (value?.statusCode == 200)
            ? controlSuccessful(value)
            : value?.statusCode == 404
                ? funcErrorInfo(LocaleKeys.mailNotFound.locale)
                : value?.statusCode == 401
                    ? funcErrorInfo(LocaleKeys.passwordNotFound.locale)
                    : funcErrorInfo(LocaleKeys.serverError.locale);
      },
    );
  }

  // Todo: LOGIN SONUC
  void controlSuccessful(var value) {
    // Todo: LogIn islemi basariyla tamamlandi cache'e token kaydini yap ve anasayfaya gec.
    context
        .read<AuthRegisterProvider>()
        .addUserToCache(token: value?.token, name: value?.name); //!
    Routes.route(context, "/homeHomePageUi");
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
