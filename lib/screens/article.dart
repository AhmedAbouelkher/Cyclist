import 'dart:math';

import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

class HomeArticl extends StatefulWidget {
  final String coverImageUrl;
  final String title;

  const HomeArticl({Key key, this.coverImageUrl, this.title}) : super(key: key);

  @override
  _HomeArticlState createState() => _HomeArticlState();
}

class _HomeArticlState extends State<HomeArticl> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      appBar: StanderedAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: NetworkingPageHeader(
              minExtent: 150.0,
              maxExtent: 250.0,
              coverImageUrl: widget.coverImageUrl,
              title: widget?.title ?? "تعلم عن فوائد ركوب الدراجة",
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.02)),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? " *
                    5,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
    this.coverImageUrl,
    this.title,
    this.leading,
  });
  final double minExtent;
  final double maxExtent;
  final String coverImageUrl;
  final String title;
  final Widget leading;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final AppTranslations trs = AppTranslations.of(context);
    final Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          child: FancyShimmerImage(
            imageUrl: coverImageUrl,
            boxFit: BoxFit.cover,
            shimmerBaseColor: Colors.grey[200],
            shimmerHighlightColor: Colors.grey[100],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black87],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
        Align(
          alignment: trs.isArabic ? Alignment(0.9, -0.55) : Alignment(-0.9, -0.55),
          child: Container(
            child: leading ??
                CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Center(
                      child: LangReversed(
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: size.aspectRatio * 50,
                              color: Colors.black,
                            ),
                          ),
                          replacment: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: size.aspectRatio * 50,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
