import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cyclist/utils/colors.dart';

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
    backgroundColor: CColors.blueStatusColor,
    duration: EdgeAlert.LENGTH_SHORT,
    description: desc,
    gravity: EdgeAlert.TOP,
  );
}
