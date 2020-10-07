import 'package:flutter/material.dart';

class CColors {
  // @deprecated
  // static const Color redColor = const Color(0xFF711104);
  // @deprecated
  // static const Color blueStatusColor = const Color(0xFF921EB4);
  // @deprecated
  // static const Color orderStatusOnItsWay = const Color(0xFF361EB4);
  // @deprecated
  // static const Color statusBarClolor = const Color(0xFF7FAD39);
  // @deprecated
  // static const Color activeCatColor = const Color(0xFF7FAD39);
  // // static const Color darkBlue = const Color(0xFFA4CF62);
  // @deprecated
  // static const Color darkBlueColor = const Color(0xFF63901D);
  // @deprecated
  // static const Color blueFontColor = const Color(0xFF63901D);
  // @deprecated
  // static const Color serachFeildColor = const Color(0xFF63901D);
  // @deprecated
  // static const Color appBarColorOpacity = const Color(0xFF63901D);
  // @deprecated
  // static const Color appBarColor = const Color(0xFF7FAD39);
  // @deprecated
  // static const Color inActiveIcon = const Color(0xFF416804);
  // @deprecated
  // static const Color iconColor = const Color(0x4A416804);
  // @deprecated
  // static const Color darkFontColor = const Color(0xFF14242C);
  // @deprecated
  // static const Color activestarColor = const Color(0xFFFFA200);
  // @deprecated
  // static const Color inActiveButtonColor = const Color(0xFFD8D8D8);
  @deprecated
  static const Color inActivestarColor = const Color(0xFFD8D8D8);
  @deprecated
  static const Color inActiveCatColor = const Color(0xFFE0F3FF);
  @deprecated
  static const Color greenColor = const Color(0xFF5FE039);
  @deprecated
  static const Color darkGreenColor = const Color(0xFF0C922B);
  // @deprecated
  // static const LinearGradient gradient = LinearGradient(
  //   colors: [
  //     statusBarClolor,
  //     darkBlue,
  //     statusBarClolor,
  //   ],
  // );

  /*
    Greens
  */
  ///Light Gradient Color
  static const Color superLightGreen = Color(0xFF9EF6FC);
  static const Color superLightGreenAccent = Color(0xFFBED9C1);
  static const Color fancyGreen = Color(0xFF00CCAA);
  static const Color lightTextGreen = Color(0xFFE6FF00);
  static const Color lightDarkGreen = Color(0xFFACFA05);
  static const Color lightGreenAccent = Color(0xFF97ED12);
  static const Color lightGreenAccent2 = Color(0xFF9046F3);
  static const Color boldLightGreen = Color(0xFF5DC400);
  static const Color lightGreenAccent3 = Color(0xFFC839CB);
  static const Color lightGreen = Color(0xFF36a9e1);
  static const Color paleLightGreen = Color(0xFF317F44);

  ///Dark Gradient Color
  static const Color darkGreen = Color(0xFF36a9e1);
  // static const Color darkGreen = Color(0xFF2E8BA2);
  // static const Color darkGreenAccent = Color(0xFF691975);
  static const Color darkGreenAccent = Color(0xFF00405f);
  static const Color greyeshDarkGreen = Color(0xFF2591B1);
  static const Color palehDarkGreen = Color(0xFF2B8869);
  /*
    Reds
  */
  ///Notification Badge
  static const Color bloodRed = Color(0xFFFF0000);

  ///Red bottons
  static const Color coldBloodRed = Color(0xFFDC3130);
  /*
    Blacks
  */
  static const Color lightBlack = Color(0xFFABABAB);

  ///Icons
  static const Color boldBlackAccent = Color(0xFF606060);

  ///Text
  static const Color boldBlack = Color(0xFF302F2F);
  /*
    Blues
  */
  ///Small appBar
  static const Color lightBlue = Color(0xFF4A189B);

  ///Chat bubble
  static const Color lightBlueAccent = Color(0xFF057477);

  static const Color darkBlue = Color(0xFF02323D);

  ///Dialog background color
  static const Color veryLightTransparentBlue = Color(0xFF033436);

  /*
  Whites
  */
  static const Color darkWhite = const Color(0xFFEDEAE6);
  static const Color darkWhiteAccent = const Color(0xFFF5F5F5);
  static const Color white = Colors.white;

  static const Color transparent = Colors.transparent;

  static LinearGradient famousGradient({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: [
        Color(0xff9B4DF4),
        Color(0xff412582),
      ],
      // stops: [0.1, 0.5],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient chatBubbleGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    GradientTransform transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: [
        Color(0xff12A5AA),
        Color(0xff06797C),
      ],
      // stops: [0.1, 0.5],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientOrder({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: [
        Color(0xffF3CCF6),
        Color(0xffD8E4F8),
      ],
      // stops: [0.1, 0.5],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientLinearProgressIndicator({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: [
        superLightGreen,
        Color(0xff35A8B5),
      ],
      // stops: [0.1, 0.5],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientLinearProgressIndicatorBackground({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    GradientTransform transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: [
        Color(0xffDBDBDB),
        Color(0xffBDBDBD),
      ],
      // colors: [Color(0xffDBDBDB), Colors.red],
      // stops: [0.1, 0.5],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }
}
