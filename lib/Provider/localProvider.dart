import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale =  Locale('id');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}
