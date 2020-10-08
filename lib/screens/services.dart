import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesTap extends StatefulWidget {
  @override
  _ServicesTapState createState() => _ServicesTapState();
}

class _ServicesTapState extends State<ServicesTap> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.wrench, color: CColors.darkGreenAccent),
              SizedBox(width: 10),
              Text(trs.translate("service"), style: TextStyle(color: CColors.boldBlack, fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}
