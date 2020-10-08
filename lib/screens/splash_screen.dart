import 'package:cyclist/screens/home_screen.dart';
import 'package:cyclist/widgets/custom_page_transition.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    Future.delayed(Duration(milliseconds: 1300)).then(
      (value) {
        Navigator.pushReplacement(
          context,
          CustomPageRoute(
            builder: (_) => Home(),
            duration: Duration(milliseconds: 350),
          ),
        );
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
}
