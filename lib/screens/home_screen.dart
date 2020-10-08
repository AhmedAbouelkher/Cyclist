import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cyclist/screens/HomeScreens/home.dart';
import 'package:cyclist/screens/maps/map.dart';
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
    // ServicesTap(),
    HalaLafaTap(),
    // NotificationsTap(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // final _l = DateFormat('H:m:s').format(DateTime.now());
      //     // final _result = "2020-10-05 " + _l;
      //     // print(DateFormat.jm().format(DateTime.parse("2020-10-05 " + _result)));
      //     print(DateFormat('H:m:s').format(TimeOfDay.now().timeOfDayToDateTime()));
      //   },
      // ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: CColors.darkGreen,
        items: [
          TabItem(icon: Icons.home, title: trs.translate("home_screen")),
          // TabItem(icon: FontAwesomeIcons.wrench, title: trs.translate("service")),
          TabItem(icon: FontAwesomeIcons.mapMarkerAlt, title: trs.translate("yala_lafa")),
          // TabItem(icon: Icons.notifications, title: trs.translate("notifications")),
          TabItem(icon: Icons.settings, title: trs.translate("settings")),
        ],
        initialActiveIndex: _screenIndex, //optional, default as 0
        onTap: (int i) => setState(() => _screenIndex = i),
      ),
      body: SafeArea(
        child: _taps[_screenIndex],
      ),
      // body: SafeArea(
      //   child: IndexedStack(
      //     index: _screenIndex,
      //     children: _taps,
      //   ),
      // ),
    );
  }
}
