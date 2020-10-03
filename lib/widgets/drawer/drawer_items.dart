import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
  DrawerItems({this.text, this.onTap, this.icon});
  final String text;
  final Function onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(right: size.width * 0.10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(width: size.width * 0.05),
            Text(text, style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
