import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  WidgetBuilder builder;
  CustomPageRoute({
    @required this.builder,
    Duration duration,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: duration ?? Duration(milliseconds: 200),
        );
}
