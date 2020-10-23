import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cyclist/Services/Config/remote_config.dart';
import 'package:cyclist/screens/HomeScreens/home.dart';
import 'package:cyclist/screens/maps/map.dart';
import 'package:cyclist/screens/settings_screen.dart';
import 'package:cyclist/utils/alert_manager.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  int _screenIndex = 0;
  final List<Widget> _taps = [
    HomeTap(),
    HalaLafaTap(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(DateFormat("yyyy-MM-dd h:mm a").format(DateTime.now()));
      //   },
      // ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.titled,
        backgroundColor: CColors.darkGreen,
        items: [
          TabItem(icon: Icons.home, title: trs.translate("home_screen")),
          TabItem(icon: FontAwesomeIcons.mapMarkerAlt, title: trs.translate("yala_lafa")),
          TabItem(icon: Icons.settings, title: trs.translate("settings")),
        ],
        initialActiveIndex: _screenIndex, //optional, default as 0
        onTap: (int i) => setState(() => _screenIndex = i),
      ),
      body: SafeArea(
        child: _taps[_screenIndex],
      ),
    );
  }

  Future<void> _dialog;

  @override
  void afterFirstLayout(BuildContext context) {
    final bool _isTrialPeroidOn = PreferenceUtils.getInstance().getValueWithKey(trialPeroidKey);
    if (_isTrialPeroidOn) {
      Timer.periodic(Duration(minutes: 2), (_) => _checkAndShowDialog());
    }
  }

  void _checkAndShowDialog() async {
    if (_dialog == null) {
      _dialog = showTrialPeriodAlert(context: context);
      await _dialog;
      _dialog = null;
    }
  }
}
