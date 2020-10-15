import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

void alertWithErr({BuildContext context, String msg, String desc}) {
  EdgeAlert.show(
    context,
    title: msg,
    icon: FontAwesomeIcons.times,
    backgroundColor: const Color.fromRGBO(195, 25, 26, 1),
    duration: EdgeAlert.LENGTH_SHORT,
    description: desc,
    gravity: EdgeAlert.TOP,
  );
}

void alertWithSuccess({BuildContext context, String msg, String desc}) {
  EdgeAlert.show(
    context,
    title: msg,
    icon: FontAwesomeIcons.check,
    backgroundColor: CColors.darkGreenAccent,
    duration: EdgeAlert.LENGTH_SHORT,
    description: desc,
    gravity: EdgeAlert.TOP,
  );
}

Future<void> showTrialPeriodAlert({BuildContext context}) async {
  final AppTranslations trs = AppTranslations.of(context);
  return showDialog<void>(
    context: context,
    useSafeArea: true,
    builder: (context) {
      return PlatformAlertDialog(
        title: Text(
          trs.translate("info"),
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(FontAwesomeIcons.phoneAlt),
            ),
            Text(trs.translate("app_traild_peroid_expiration"), style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText(trs.translate("ok"), style: TextStyle(fontSize: 12)),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          PlatformDialogAction(
            child: PlatformText(trs.translate("call"), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
              try {
                UrlLauncher.launch("tel://201200954866");
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      );
    },
  );
}
