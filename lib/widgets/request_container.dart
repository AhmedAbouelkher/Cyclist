import 'package:flutter/material.dart';

class RequestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // final AppTranslations trs = AppTranslations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AcceptCard(
                time: '3:00 PM',
                date: '14-5-1441',
                text: 'الموافقه علي الطلب 1213',
              ),
              AcceptCard(
                time: '3:00 PM',
                date: '14-5-1441',
                text: 'الموافقه علي الطلب 1213',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AcceptCard extends StatelessWidget {
  final String time;
  final String date;
  final String text;
  AcceptCard({this.time, this.date, this.text});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(bottom: size.height * 0.009),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.009, horizontal: size.width * 0.05),
        height: size.height * 0.11,
        color: Colors.yellow[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  time,
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            Text(
              text,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
