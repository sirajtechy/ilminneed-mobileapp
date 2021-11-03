import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class HintWidget extends StatelessWidget {
  final String label;

  const HintWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 15, right: 15),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: mediumTextStyle().copyWith(color: konLightColor),
      ),
    );
  }
}
