import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CenterError extends StatelessWidget {
  final String message;
  final Widget title;
  final IconData icon;
  final VoidCallback onReload;
  final String buttomText;
  final MainAxisAlignment mainAxisAlignment;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;

  const CenterError({
    Key key,
    this.message,
    this.icon,
    this.title,
    this.onReload,
    this.buttomText,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.alignment = Alignment.center,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: margin ?? const EdgeInsets.all(0.0),
      child: Align(
        alignment: alignment,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            Opacity(
              opacity: 0.4,
              child: icon == null
                  ? Container()
                  : FaIcon(
                      icon,
                      color: CColors.darkGreen,
                      size: size.width / 3,
                    ),
            ),
            SizedBox(height: size.height * 0.02),
            title ??
                Text(
                  message,
                  style: TextStyle(
                    color: CColors.lightGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
            SizedBox(height: size.height * 0.03),
            onReload != null
                ? OutlineButton(
                    onPressed: onReload,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      buttomText ?? AppTranslations.of(context).translate("retry"),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
