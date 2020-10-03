import 'package:flutter/material.dart';
import 'package:cyclist/utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum locales { ar, en }

class LangRepo {
  Future<bool> hasLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localeName = prefs.getString(Keys.langKey);
    return localeName != null && localeName != '';
  }

  Future setLocale({@required locales locale}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (locale) {
      case locales.ar:
        prefs.setString(Keys.langKey, 'ar');
        break;
      case locales.en:
        prefs.setString(Keys.langKey, 'en');
        break;
    }
  }

  Future<String> getLocaleCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localeCode = prefs.getString(Keys.langKey);
    if (localeCode != null && localeCode != '') {
      return localeCode;
    } else {
      return 'ar';
    }
  }
}
