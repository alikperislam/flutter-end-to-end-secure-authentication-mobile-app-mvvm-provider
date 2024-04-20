import 'package:easy_localization/easy_localization.dart';
import 'package:enguide_app/src/core/enums/language_enums.dart';
import 'package:enguide_app/src/core/init/localization/language.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // ignore: unused_field
  late LanguageEnum _language;
  void languageChoose(LanguageEnum language, BuildContext context) {
    switch (language) {
      case LanguageEnum.tr:
        _language = language;
        context.setLocale(LanguageManager.instance.trLocale);
      case LanguageEnum.pt:
        _language = language;
        context.setLocale(LanguageManager.instance.ptLocale);
      case LanguageEnum.ru:
        _language = language;
        context.setLocale(LanguageManager.instance.ruLocale);
      case LanguageEnum.de:
        _language = language;
        context.setLocale(LanguageManager.instance.deLocale);
      case LanguageEnum.it:
        _language = language;
        context.setLocale(LanguageManager.instance.itLocale);
      case LanguageEnum.es:
        _language = language;
        context.setLocale(LanguageManager.instance.esLocale);
    }
    notifyListeners();
  }
}
