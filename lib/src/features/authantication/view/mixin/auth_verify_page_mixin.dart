import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/routing/routes.dart';
import 'package:enguide_app/src/core/widgets/custom_snackbar_widget.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_signin_provider.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_verify_provider.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_verify_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

mixin AuthVerifyPageMixin on State<AuthVerifyPageUi> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //? sayfa acildiginda ustten baslamasi icin 1.0 veriyoruz.
    Future.delayed(const Duration(milliseconds: 10), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(context, alignment: 1.0);
      });
    });
  }

  late TextEditingController textController;
  late FocusNode focusNodePinPut;

  @override
  void initState() {
    super.initState();
    //? sayfa ilk acildiginda nesne uretilecek.
    textController = TextEditingController();
    focusNodePinPut = FocusNode();
  }

  @override
  void dispose() {
    //? sayfa kapandiginda bellekteki tum controllerlar birakilacak.
    textController.dispose();
    focusNodePinPut.dispose();
    super.dispose();
  }

  funcPinputController(Object keyData) {
    if (keyData is num) {
      // kod kutucuklari tamamen dolduruldugunda odak sonlansin.
      textController.text.length < 6
          ? FocusScope.of(context).requestFocus(focusNodePinPut)
          : FocusScope.of(context).requestFocus(FocusNode());
      // girilen her rakami sirayla ekler, 6. elemandan sonra eleman eklemez.
      textController.append(keyData.toString(), 6);
    } else {
      //? silme islemleri yapilacak.
      if (textController.length > 0) {
        // dogrulama kodunun son elemanini siler.
        String setCode =
            textController.text.substring(0, textController.text.length - 1);
        // son elemani silindikten sonra dogrulama kodunu gunceller.
        textController.setText(setCode);
        // silme islemi sirasinda kutucukta odak saglansin.
        FocusScope.of(context).requestFocus(focusNodePinPut);
        return;
      }
    }
  }

  funcVerifyCodeController() async {
    final verifyCode =
        context.read<AuthVerifyProvider>().getVerifyCode.toString();
    final inputCode =
        context.read<AuthVerifyProvider>().getUserInputCode.toString();
    if (inputCode.isNotEmpty && inputCode.length == 6) {
      if (verifyCode == inputCode) {
        //! mail dogrulandi -> kullanici datalarini mySQL'e gonder ve kayit islemini bitir diger sayfaya gec.
        await context.read<AuthSigninProvider>().funcPostSignIn().then(
          (value) {
            // Todo: Sunucu ile baglanti varsa tekrar mail gonderilsin mi islemi.
            funcSignInServerController(value);
          },
        );
      } else {
        funcErrorInfo(
          LocaleKeys.codeIsFalse.locale,
          ContentType.failure,
          LocaleKeys.attention.locale,
        );
      }
    } else {
      funcErrorInfo(
        LocaleKeys.warningNullBox.locale,
        ContentType.failure,
        LocaleKeys.attention.locale,
      );
    }
  }

  funcSignInServerController(var value) {
    if (value != null) {
      String name = context
          .read<AuthSigninProvider>()
          .authSignInModel!
          .nameText!
          .firstElement;
      // Todo: cache'e token ve name kaydini yap.
      context
          .read<AuthRegisterProvider>()
          .addUserToCache(token: value.token, name: name);
      // Todo: anasayfaya gecis islemini yap.
      Routes.route(context, "/homeHomePageUi");
    } else {
      //! islem basarisiz kayit islemi yapilamadi!
      funcErrorInfo(
        LocaleKeys.registrationFailed.locale,
        ContentType.failure,
        LocaleKeys.attention.locale,
      );
    }
  }

  funcVerifyCodeSendMail() async {
    if (context.read<AuthVerifyProvider>().againButtonIsClick == false) {
      //? yeni bir andom dogrulama kodu olustur.
      context.read<AuthVerifyProvider>().randomCodeGenerator();
      //? mail gonderme islemi.
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
          // Todo: Sunucu ile baglanti varsa tekrar mail gonderilsin mi islemi.
          funcMailServerController(value);
        },
      );
    } else {
      //! daha fazla mail atilamaz uyarisi.
      funcErrorInfo(
        LocaleKeys.noMessageSentAgain.locale,
        ContentType.failure,
        LocaleKeys.attention.locale,
      );
    }
  }

  funcMailServerController(var value) {
    if (value != null) {
      //
      funcErrorInfo(
        LocaleKeys.messageSentAgain.locale,
        ContentType.success,
        LocaleKeys.successful.locale,
      );
      //? ayni mail adresine 2. mailden sonra daha fazla mailin atilmasini engelle.
      context.read<AuthVerifyProvider>().againButtonClickEvent(true);
    } else {
      //
      funcErrorInfo(
        LocaleKeys.serverError.locale,
        ContentType.failure,
        LocaleKeys.attention.locale,
      );
      context.read<AuthVerifyProvider>().againButtonClickEvent(false);
    }
  }

  funcErrorInfo(String message, ContentType type, String title) {
    CustomSnackBar.customSnackBar(
      errorMessage: message,
      contentType: type,
      title: title,
      context: context,
    );
  }
}
