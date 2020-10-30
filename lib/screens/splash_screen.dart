import 'package:cyclist/Services/Config/remote_config.dart';
import 'package:cyclist/screens/home_screen.dart';
import 'package:cyclist/utils/constants.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:cyclist/widgets/custom_page_transition.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  RemoteConfigService _remoteConfig;
  RemoteConfig _remote;
  @override
  void initState() {
    RemoteConfig.instance.then((value) async {
      _remote = value;
      await _remote.setConfigSettings(RemoteConfigSettings(debugMode: false));
      _remoteConfig = RemoteConfigService(remoteConfig: _remote);
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    Future.delayed(Duration(milliseconds: 1300)).then(
      (value) async {
        _requestLocationPermission();
        await _remoteConfig.initialise();
        await PreferenceUtils.getInstance().saveValueWithKey<bool>(trialPeroidKey, _remoteConfig.isInTrielPeroid);
        print("@Trial Version #${_remoteConfig.isInTrielPeroid}");
        Constants.setApiKey = _remoteConfig.apiKey;
        Navigator.pushReplacement(context, CustomPageRoute(builder: (_) => Home(), duration: Duration(milliseconds: 400)));
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
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
      body: Align(
        alignment: Alignment(0, 0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Image.asset(
              "assets/Native/csplash.png",
              width: size.width * (0.5 + _animation.value * 0.1),
            );
          },
        ),
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    Location location = Location.instance;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
