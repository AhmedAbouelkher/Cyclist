import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';

class NumperPciker extends StatefulWidget {
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final int initialValue;
  final borderColor = Colors.black38;
  final int minimum;

  NumperPciker({
    this.initialValue,
    this.minimum,
    this.onMinus,
    this.onPlus,
  });

  @override
  _NumperPcikerState createState() => _NumperPcikerState();
}

class _NumperPcikerState extends State<NumperPciker> {
  int count;
  int min;

  @override
  void initState() {
    count = widget.initialValue;
    if (widget.minimum == null) {
      min = 0;
    } else {
      min = widget.minimum;
    }
    super.initState();
  }

  // @override
  // void didUpdateWidget(NumperPciker oldWidget) {
  //   if (oldWidget.initialValue != widget.initialValue) {
  //     count = widget.initialValue;
  //     if (widget.minimum == null) {
  //       min = 0;
  //     } else {
  //       min = widget.minimum;
  //     }
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  _setState(VoidCallback state) {
    if (mounted) setState(state);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final trs = AppTranslations.of(context);
    return Directionality(
      textDirection: trs.currentLanguage == 'ar' ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        height: size.width * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width * 0.08,
              height: size.width * 0.07,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: CColors.redColor,
                ),
                onPressed: () {
                  _setState(() => count++);
                  if (widget.onPlus != null) widget.onPlus();
                },
              ),
            ),
            Container(
              width: size.width * 0.15,
              height: size.width * 0.07,
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, -2.5),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.08,
              height: size.width * 0.07,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.remove,
                  size: 20,
                  color: CColors.redColor,
                ),
                onPressed: () {
                  if (count == 1) return;
                  _setState(() => count--);
                  if (widget.onMinus != null) widget.onMinus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
