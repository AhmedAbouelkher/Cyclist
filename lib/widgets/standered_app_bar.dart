import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';

enum AppBarType { placeholder, transparent }

class StanderedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;
  final Widget centerChild;
  final Widget trailing;
  final Widget leading;
  final Color backgroundColor;
  const StanderedAppBar({
    Key key,
    this.appBarType = AppBarType.placeholder,
    this.centerChild,
    this.trailing,
    this.backgroundColor,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    Widget appBar = Container(
      color: backgroundColor ?? CColors.appBarColor.withOpacity(0.65),
      height: size.height * 0.06,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: trs.currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
              child: leading ??
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: size.aspectRatio * 35,
                    ),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
            ),
            Center(child: centerChild),
            Align(
              alignment: trs.currentLanguage != 'ar' ? Alignment.centerRight : Alignment.centerLeft,
              child: trailing,
            ),
          ],
        ),
      ),
    );
    switch (appBarType) {
      case AppBarType.placeholder:
        return AppBar(
          backgroundColor: backgroundColor ?? CColors.activeCatColor,
          centerTitle: true,
          title: centerChild,
          elevation: 0,
        );
        break;
      case AppBarType.transparent:
        return appBar;
        break;
    }
    return Container();
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
