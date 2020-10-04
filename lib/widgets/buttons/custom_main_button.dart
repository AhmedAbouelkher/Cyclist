import 'package:cyclist/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onTap;
  final double borderRaduis;
  final String text;
  final double textSize;
  final bool outline;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color bgColor;
  CustomMainButton({
    this.width,
    this.height,
    this.onTap,
    this.text,
    this.borderRaduis = 20,
    this.textSize,
    this.outline = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.bgColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    if (outline) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: width == null ? padding : null,
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRaduis),
              ),
              border: Border.all(
                color: CColors.darkGreen,
                width: 0.8,
              )),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: CColors.boldBlack, fontSize: textSize ?? 15),
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: width == null ? padding : null,
        decoration: BoxDecoration(
          gradient: bgColor != null ? null : CColors.gradient,
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRaduis),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: textSize ?? 15),
          ),
        ),
      ),
    );
  }
}
