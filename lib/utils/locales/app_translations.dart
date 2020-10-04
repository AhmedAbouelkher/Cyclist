import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent = await rootBundle.loadString("lang/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  TextDirection get currentTextDirection => !isArabic ? TextDirection.ltr : TextDirection.rtl;
  String get currentLanguage => locale.languageCode;
  bool get isArabic => locale.languageCode == 'ar';
  bool get isEnglish => locale.languageCode == 'en';
  TextDirection get directionReversed => isArabic ? TextDirection.ltr : TextDirection.rtl;

  String translate(String key) {
    if (_localisedValues == null) return isArabic ? 'تحميل...' : 'loading...';
    return _localisedValues[key] ?? "$key not found";
  }
}

///Arabic is the baseline for this widget
class LangReversed extends StatelessWidget {
  final Widget child;
  final Widget replacment;
  const LangReversed({
    Key key,
    @required this.child,
    @required this.replacment,
  })  : assert(child != null && replacment != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    if (trs.isArabic) {
      return child;
    }
    return replacment;
  }
}
