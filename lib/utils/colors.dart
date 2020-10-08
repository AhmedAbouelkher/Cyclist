import 'package:flutter/material.dart';

class CColors {
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
