import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/enums.dart';
import 'package:cyclist/utils/locales/app_translations.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  final Function onChanged;
  GenderPicker({this.onChanged});
  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  Gender selectedGender;
  @override
  void initState() {
    selectedGender = Gender.male;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppTranslations trs = AppTranslations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        customButton(
          height: size.height * 0.065,
          width: size.width * 0.4,
          onTap: () {
            setState(() {
              selectedGender = Gender.male;
              widget.onChanged('male');
            });
          },
          text: trs.translate('male'),
          gender: Gender.male,
        ),
        customButton(
          height: size.height * 0.065,
          width: size.width * 0.4,
          onTap: () {
            setState(() {
              selectedGender = Gender.female;
              widget.onChanged('female');
            });
          },
          text: trs.translate('female'),
          gender: Gender.female,
        ),
      ],
    );
  }

  Widget customButton({
    double width,
    double height,
    String text,
    Function onTap,
    Gender gender,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: selectedGender == gender ? CColors.gradient : null,
          border: Border.all(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selectedGender == gender ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
