import 'package:cyclist/screens/home_screen.dart';
import 'package:cyclist/utils/images.dart';
import 'package:cyclist/widgets/custom_page_transition.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // RemoteConfigService _remoteConfig;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        Navigator.pushReplacement(
          context,
          CustomPageRoute(
            builder: (_) => Home(),
          ),
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => HomeScreen(),
        //   ),
        // );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Center(
        child: Text("Splash Screen"),
      ),
      // body: Center(
      //   child: Image.asset(
      //     Constants.logoV,
      //     width: size.width * 0.6,
      //   ),
      // ),
    );
  }
}
