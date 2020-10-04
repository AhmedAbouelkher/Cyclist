import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cyclist/screens/article.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTap extends StatefulWidget {
  @override
  _HomeTapState createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.home, color: CColors.darkGreenAccent),
              SizedBox(width: 10),
              Text(trs.translate("home_tab"), style: TextStyle(color: CColors.boldBlack, fontSize: 18)),
            ],
          ),
        ),
        SizedBox(height: 20),
        HomeItem(
          coverImageUrl: "https://i.insider.com/58e1228877bb7028008b5aef?width=1100&format=jpeg&auto=webp",
          title: trs.translate("bicyle_befits"),
          onTap: () {
            Navigator.push(
                context,
                platformPageRoute(
                  context: context,
                  builder: (context) => HomeArticl(
                    coverImageUrl: "https://i.insider.com/58e1228877bb7028008b5aef?width=1100&format=jpeg&auto=webp",
                    // title: trs.translate("bicyle_befits"),
                  ),
                ));
          },
        ),
        HomeItem(
          coverImageUrl: "https://blog.mapmyrun.com/wp-content/uploads/2017/10/5-Handy-Tips-on-Buying-a-Used-Bike.jpg",
          title: trs.translate("bicycle_purchase_advice"),
          onTap: () {},
        ),
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  final String coverImageUrl;
  final String title;
  final VoidCallback onTap;

  const HomeItem({
    Key key,
    @required this.coverImageUrl,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Container(
      height: size.height * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: CColors.boldBlack,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            blurRadius: 15,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                    child: FancyShimmerImage(
                      imageUrl: coverImageUrl,
                      boxFit: BoxFit.cover,
                      shimmerBaseColor: Colors.grey[200],
                      shimmerHighlightColor: Colors.grey[100],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: [Colors.transparent, Colors.black.withOpacity(1)],
                        ).createShader(Rect.fromLTRB(50, -200, rect.width, 0));
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: FadeAnimatedTextKit(
                    text: [trs.translate("click_to_learn_more")],
                    repeatForever: true,
                    textStyle: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
