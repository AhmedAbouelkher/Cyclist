import 'package:cyclist/screens/home_screen%20(dep)/home_screen.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/buttons/custom_main_button.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationSubmitted extends StatefulWidget {
  @override
  _ApplicationSubmittedState createState() => _ApplicationSubmittedState();
}

class _ApplicationSubmittedState extends State<ApplicationSubmitted> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    Future.delayed(Duration(milliseconds: 300), () {
      _animationController?.forward();
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
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SuccessMark(_animation),
            Column(
              children: <Widget>[
                Text(trs.translate('order_submitted'), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    trs.translate('order_submitted_desc1'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                CustomMainButton(
                  outline: true,
                  text: trs.translate("back_to_home_screen"),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  height: 50,
                  borderRaduis: 10,
                  textSize: 15,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessMark extends AnimatedWidget {
  SuccessMark(Animation animatedContainer) : super(listenable: animatedContainer);

  double get value => (listenable as Animation).value;
  double get valueRev => 1.0 - (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CircleAvatar(
      radius: size.aspectRatio * (150 - 20 * valueRev),
      backgroundColor: ColorTween(begin: Colors.amber, end: Colors.green).evaluate(listenable),
      child: Opacity(
        opacity: value,
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
          size: size.aspectRatio * 150,
        ),
      ),
    );
  }
}
