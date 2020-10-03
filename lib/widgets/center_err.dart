import 'package:cyclist/utils/colors.dart';
import 'package:flutter/material.dart';

class CenterErr extends StatelessWidget {
  final String msg;
  final IconData icon;
  CenterErr({this.msg, this.icon});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: CColors.appBarColor.withAlpha(150), size: size.aspectRatio * 250),
          SizedBox(height: size.height * 0.05, width: size.width * 0.05),
          Text(
            msg,
            style: TextStyle(
              color: CColors.appBarColor,
              fontSize: size.aspectRatio * 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
