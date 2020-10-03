import 'package:flutter/material.dart';

class NoRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text('لاتوجد طلبات حتي الان')
        // Image(
        //   image: AssetImage(),
        // ),
      ),
    ));
  }
}
