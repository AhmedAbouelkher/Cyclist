import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CStepper extends StatelessWidget {
  final int initailIndex;
  final VoidCallback onTapToRate;
  CStepper({Key key, @required this.initailIndex, this.onTapToRate})
      : assert(initailIndex != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<IconData> _icons = [
      FontAwesomeIcons.check,
      FontAwesomeIcons.houzz,
      FontAwesomeIcons.truck,
      FontAwesomeIcons.shoppingBag,
    ];
    // final List<String> _iconsPath = [
    //   orderStage1SVG,
    //   orderStage2SVG,
    //   orderStage3SVG,
    //   orderStage4SVG,
    // ];
    AppTranslations trs = AppTranslations.of(context);
    Size size = MediaQuery.of(context).size;
    if (_icons.length == 3) {
      _icons.add(trs.currentLanguage == 'ar' ? FontAwesomeIcons.angleDoubleRight : FontAwesomeIcons.angleDoubleLeft);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Directionality(
        textDirection: trs.currentLanguage == 'ar' ? TextDirection.ltr : TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            bool isStageSelected = initailIndex >= index;
            bool isStageLineSelected = initailIndex >= (index - 1);
            bool isOrderFinished = initailIndex == index && index == 3;
            return Row(
              children: <Widget>[
                _buildLine(index, isStageLineSelected),
                GestureDetector(
                  onTap: () {
                    if (isOrderFinished) {
                      if (onTapToRate != null) onTapToRate();
                    } else {
                      return;
                    }
                  },
                  child: Container(
                    height: size.width * 0.12,
                    width: size.width * 0.12,
                    decoration: BoxDecoration(
                      color: isOrderFinished ? CColors.blueStatusColor : (isStageSelected ? CColors.statusBarClolor : CColors.inActiveCatColor),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      // child: SvgPicture.asset(
                      //   _iconsPath[2],
                      //   color: isStageSelected ? Colors.white : inActiveIcon,
                      //   height: 15,
                      //   width: 15,
                      // ),
                      child: FaIcon(
                        _icons[index],
                        size: 15,
                        color: isStageSelected ? Colors.white : CColors.inActiveIcon,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLine(int index, bool isSelected) {
    if (index == 0) {
      return Container();
    }
    return Container(
      height: 3,
      width: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black54 : Colors.grey,
      ),
    );
  }
}
