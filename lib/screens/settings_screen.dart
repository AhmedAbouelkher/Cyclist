import 'package:cyclist/Controllers/repositories/lang_repo.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/change_lang.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _handleChangeLang() async {
    String _currentLang = AppTranslations.of(context).currentLanguage;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeLang();
      },
    );
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        String _currentLang2 = AppTranslations.of(context).currentLanguage;
        if (_currentLang != _currentLang2) {
          _showLangChangeSuggestion(AppTranslations.of(context), context);
        }
      }
    });
  }

  void _showLangChangeSuggestion(AppTranslations trs, BuildContext context) async {
    final trs = AppTranslations.of(context);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Center(
            child: Text(
              trs.translate("info"),
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.redoAlt,
                  size: 40,
                ),
              ),
              Text(
                trs.translate("restart_to_apply_lang"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(trs.translate("close")),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(Icons.settings, color: CColors.darkGreenAccent),
                    SizedBox(width: 10),
                    Text(trs.translate("settings"), style: TextStyle(color: CColors.boldBlack, fontSize: 18 * .8)),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: _handleChangeLang,
                    child: ListTile(
                      // contentPadding: EdgeInsets.all(0),
                      leading: Icon(FontAwesomeIcons.language),
                      title: Text(
                        trs.translate("app_lang"),
                        style: TextStyle(fontSize: 13 * .8),
                      ),
                    ),
                  ),
                  DviderRow(),
                  ListTile(
                    // contentPadding: EdgeInsets.all(0),
                    leading: Icon(FontAwesomeIcons.fileAlt),
                    onTap: () async {
                      // await _launchURL("terms");
                    },
                    title: Text(
                      trs.translate("use_policy"),
                      style: TextStyle(fontSize: 13 * .8),
                    ),
                  ),
                  // DviderRow(),
                  // ListTile(
                  //   // contentPadding: EdgeInsets.all(0),
                  //   leading: Icon(FontAwesomeIcons.shippingFast),
                  //   onTap: () async {
                  //     await _launchURL("shipping-and-delivery");
                  //   },
                  //   title: Text(
                  //     trs.translate("shipping_and_delivery"),
                  //     style: TextStyle(fontSize: 13),
                  //   ),
                  // ),
                  // DviderRow(),
                  // ListTile(
                  //   // contentPadding: EdgeInsets.all(0),
                  //   leading: Icon(FontAwesomeIcons.slash),
                  //   onTap: () async {
                  //     await _launchURL("cancellation-of-requests-and-support");
                  //   },
                  //   title: Text(
                  //     trs.translate("cancellation-of-requests-and-support"),
                  //     style: TextStyle(fontSize: 13),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _launchURL(String path) async {
    String langCode = await LangRepo().getLocaleCode();
    final url = 'https://www.mazajasly.com/$langCode/$path';
    if (await canLaunch(url)) {
      await launch(url, statusBarBrightness: Brightness.light);
    } else {
      print('Could not launch $url');
    }
  }
}

class DviderRow extends StatelessWidget {
  final Color color;

  const DviderRow({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Colors.grey[300],
    );
  }
}
