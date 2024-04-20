import 'package:enguide_app/src/features/authantication/provider/auth_verify_provider.dart';
import 'package:enguide_app/src/features/authantication/view/ui/auth_register_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:provider/provider.dart';

mixin AuthRegisterPageMixin on State<AuthRegisterPageUi> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //? sayfa acildiginda ustte kalmamasi icin reverse ozelligini false yapiyoruz.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(context, alignment: 1.0);
    });
  }

  void functionClickToBack() {
    //? eger verify sayfasindan donus yapiliyorsa
    if (context.read<AuthRegisterProvider>().verify == true) {
      context.read<AuthRegisterProvider>().changeVerify(value: false);
      // sayfadan cikildiginda again butonunu tekrar kullanilabilir hale getir.
      context.read<AuthVerifyProvider>().againButtonClickEvent(false);
    }
  }
}
