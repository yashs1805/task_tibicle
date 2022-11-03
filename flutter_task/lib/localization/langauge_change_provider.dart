import 'package:flutter/cupertino.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale _currentLocale = new Locale('hi');

  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale) {
    this._currentLocale = new Locale(_locale);
    notifyListeners();
  }
}
