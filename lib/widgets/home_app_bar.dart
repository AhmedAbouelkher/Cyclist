import 'package:cyclist/screens/other/settings_screen.dart';
import 'package:cyclist/screens/search_screen.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget {
  final int notiCount;
  HomeAppBar({this.notiCount});
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  // HomeScreenBloc _homeScreenBloc;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    // _homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);

    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
              size: size.aspectRatio * 60,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              child: Hero(
                tag: "hero",
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.80,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: CColors.darkBlue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          enabled: false,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: trs.translate('search'),
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.1),
        ],
      ),
    );
  }
}
