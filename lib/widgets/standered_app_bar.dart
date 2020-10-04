import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';

enum AppBarType { placeholder, transparent, extended }

class StanderedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;
  final Widget centerChild;
  final Widget trailing;
  final Widget leading;
  final Color backgroundColor;
  final String extendedTitle;
  final List<Widget> trailingActions;
  const StanderedAppBar({
    Key key,
    this.appBarType = AppBarType.placeholder,
    this.centerChild,
    this.trailing,
    this.backgroundColor,
    this.leading,
    this.extendedTitle,
    this.trailingActions,
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
    Widget appBarExtended = Container(
      height: size.height * 0.08,
      width: size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        // gradient: CColors.famousGradient(
        //   end: Alignment.centerRight,
        //   begin: Alignment.centerLeft,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: <Widget>[
            //Leading
            Align(
              alignment: trs.isArabic ? Alignment(1, -0.55) : Alignment(-1, -0.55),
              child: Container(
                child: leading ??
                    IconButton(
                      padding: const EdgeInsets.all(7.0),
                      icon: LangReversed(
                          child: Icon(
                            Icons.arrow_back,
                            size: size.aspectRatio * 57,
                          ),
                          replacment: Icon(
                            Icons.arrow_forward,
                            size: size.aspectRatio * 57,
                          )),
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      // onPressed: () {
                      //   print("object");
                      // },
                    ),
              ),
            ),
            Center(child: centerChild),
            //Trailing
            Align(
              alignment: trs.isArabic ? Alignment.topLeft : Alignment.topRight,
              child: trailingActions != null && trailingActions.isNotEmpty
                  ? Row(
                      children: trailingActions,
                    )
                  : Container(),
            ),
            Align(
              alignment: trs.isArabic ? Alignment(0.8, 0.65) : Alignment(-0.8, 0.65),
              child: Text(
                extendedTitle ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    switch (appBarType) {
      case AppBarType.placeholder:
        return AppBar(
          backgroundColor: backgroundColor ?? CColors.darkGreenAccent,
          centerTitle: true,
          title: centerChild,
          elevation: 0,
          brightness: Brightness.dark,
        );
        break;
      case AppBarType.transparent:
        return appBar;
        break;
      case AppBarType.extended:
        return appBarExtended;
        break;
    }
    return Container();
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
