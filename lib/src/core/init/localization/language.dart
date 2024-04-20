import 'package:flutter/material.dart';

class LanguageManager {
  // lazy language instance
  static LanguageManager? _instance;
  static LanguageManager get instance =>
      (_instance == null) ? _instance = LanguageManager._initial() : _instance!;
  LanguageManager._initial();
  // languages
  final trLocale = const Locale('tr');
  final ptLocale = const Locale('pt');
  final ruLocale = const Locale('ru');
  final deLocale = const Locale('de');
  final itLocale = const Locale('it');
  final esLocale = const Locale('es');
  // supported language
  List<Locale> get supportedLocales =>
      [trLocale, ptLocale, ruLocale, deLocale, itLocale, esLocale];
}
