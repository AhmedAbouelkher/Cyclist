import 'package:auto_size_text/auto_size_text.dart';
import 'package:cyclist/models/responses/cats_response.dart';
import 'package:cyclist/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoryCircle extends StatelessWidget {
  final Category cat;
  final Function onClick;
  final bool isSlected;
  CategoryCircle({this.onClick, this.isSlected, this.cat});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onClick,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 85,
          maxHeight: 70,
        ),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 25),
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            color: isSlected ? CColors.statusBarClolor : CColors.inActiveCatColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSlected
                ? [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 5),
                      blurRadius: 10,
                    )
                  ]
                : null),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: AutoSizeText(
              cat.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                color: isSlected ? Colors.white : CColors.blueFontColor,
              ),
              minFontSize: 8,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
