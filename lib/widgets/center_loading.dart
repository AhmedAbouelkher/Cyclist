import 'package:cyclist/widgets/AdaptiveProgressIndicator.dart';
import 'package:flutter/material.dart';

class CenterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        width: size.width * 0.40,
        height: size.width * 0.40,
        child: Center(
          child: AdaptiveProgessIndicator(),
        ),
      ),
    );
  }
}
