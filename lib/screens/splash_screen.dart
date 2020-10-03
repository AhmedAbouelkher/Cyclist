import 'package:cyclist/utils/images.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';

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
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StanderedAppBar(),
      body: Center(
        child: Image.asset(
          Constants.logoV,
          width: size.width * 0.6,
        ),
      ),
    );
  }
}
