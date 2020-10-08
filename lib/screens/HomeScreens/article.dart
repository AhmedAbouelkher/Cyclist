import 'package:cyclist/models/posts/posts_response.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:cyclist/widgets/standered_app_bar.dart';
import 'package:flutter/material.dart';

class HomeArticl extends StatefulWidget {
  final String coverImageUrl;
  final String title;
  final Post post;

  const HomeArticl({Key key, this.coverImageUrl, this.title, this.post}) : super(key: key);

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
    );
  }
}
