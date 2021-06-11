import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key key, this.value}) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65),
        color: konTextInputBorderActiveColor,
      ),
      child: Center(
          child: Text(
        value,
        style: buttonTextStyle().copyWith(color: konLightColor1),
      )),
    );
  }
}
