import 'package:cyclist/utils/colors.dart';
import 'package:cyclist/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final bool enabled;
  final String text;
  final IconData icon;
  final TextInputType inputType;
  final Function onChanged;
  final TextEditingController controller;
  CustomTextFeild({
    this.text,
    this.icon,
    this.controller,
    this.onChanged,
    this.inputType,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      keyboardType: inputType,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: kLongInScreentextFieldStyle,
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: CColors.blueFontColor,
        ),
      ),
    );
  }
}
