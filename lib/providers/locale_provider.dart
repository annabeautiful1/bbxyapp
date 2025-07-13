import 'package:flutter/material.dart';

// 简化的语言提供者
final localeProvider = ValueNotifier<Locale?>(null);

class LocaleProvider {
  static const Locale defaultLocale = Locale('zh', 'CN');
  static const List<Locale> supportedLocales = [
    Locale('zh', 'CN'),
    Locale('en', 'US'),
  ];

  static Locale getCurrentLocale() {
    return localeProvider.value ?? defaultLocale;
  }

  static void setLocale(Locale locale) {
    localeProvider.value = locale;
  }
}
