import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String leading;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  const Header({
    Key key,
    @required this.title,
    this.leading,
    this.onTap,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.035,
      margin: margin ??
          EdgeInsets.only(
            bottom: size.width * 0.02,
            top: size.width * 0.04,
          ),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
          ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[300],
            Colors.lightGreen[100],
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          leading == null
              ? Container()
              : InkWell(
                  onTap: onTap,
                  child: Text(
                    leading,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
