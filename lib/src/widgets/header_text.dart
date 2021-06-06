import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class HeaderTextWidget extends StatelessWidget {
  final String label;

  const HeaderTextWidget({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        label,
        style: largeTextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
