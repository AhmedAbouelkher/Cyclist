import 'package:cyclist/Controllers/repositories/lang_repo.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/utils/locales/appliction.dart';
import 'package:cyclist/widgets/custom_main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeLang extends StatefulWidget {
  @override
  _ChangeLangState createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {
  void _onLangClicked(locales locale) {
    LangRepo().setLocale(locale: locale);

    switch (locale) {
      case locales.ar:
        application.onLocaleChanged(Locale('ar', 'العربية'));
        break;
      case locales.en:
        application.onLocaleChanged(Locale('en', 'english'));
        break;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        height: size.height * 0.20,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                trs.translate("choose_device_lang"),
                style: TextStyle(
                  fontSize: 17 * 0.8,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomMainButton(
                      bgColor: CColors.boldBlack,
                      outline: trs.currentLanguage != 'ar',
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      borderRaduis: 10,
                      onTap: () {
                        if (trs.currentLanguage == 'ar') return;
                        _onLangClicked(locales.ar);
                      },
                      text: 'عربي',
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomMainButton(
                      bgColor: CColors.boldBlack,
                      outline: trs.currentLanguage != 'en',
                      height: 50,
                      borderRaduis: 10,
                      onTap: () {
                        if (trs.currentLanguage == 'en') return;
                        _onLangClicked(locales.en);
                      },
                      text: 'English',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
