import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cyclist/screens/home.dart';
import 'package:cyclist/screens/maps/map.dart';
import 'package:cyclist/screens/services.dart';
import 'package:cyclist/screens/settings_screen.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _screenIndex = 0;
  final List<Widget> _taps = [
    HomeTap(),
    ServicesTap(),
    HalaLafaTap(),
    // NotificationsTap(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: CColors.darkGreen,
        items: [
          TabItem(icon: Icons.home, title: trs.translate("home_screen")),
          TabItem(icon: FontAwesomeIcons.wrench, title: trs.translate("service")),
          TabItem(icon: FontAwesomeIcons.mapMarkedAlt, title: trs.translate("yala_lafa")),
          // TabItem(icon: Icons.notifications, title: trs.translate("notifications")),
          TabItem(icon: Icons.settings, title: trs.translate("settings")),
        ],
        initialActiveIndex: _screenIndex, //optional, default as 0
        onTap: (int i) => setState(() => _screenIndex = i),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _screenIndex,
          children: _taps,
        ),
      ),
    );
  }
}
