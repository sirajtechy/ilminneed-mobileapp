import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final bool isActive;
  final double width;

  const ButtonWidget(
      {Key? key,
      this.value,
      this.isActive = true,
      this.width = double.infinity})
      : super(key: key);
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: width,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65),
        border: Border.all(
            color: isActive ? konTextInputBorderActiveColor : konDarkColorB1,
            width: 2),
        color: isActive ? konTextInputBorderActiveColor : Colors.white,
      ),
      child: Center(
          child: Text(
            value!,
        style: buttonTextStyle()
            .copyWith(color: isActive ? konLightColor1 : konDarkColorB1),
      )),
    );
  }
}
