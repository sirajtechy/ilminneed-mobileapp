import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LessonBottomWidget extends StatelessWidget {
  final String value;
  final IconData icon;

  const LessonBottomWidget({Key? key, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
      child: Row(
        children: [
          Container(
            child: Icon(icon),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Color(0xffF6F5FF),
                borderRadius: BorderRadius.circular(10)),
          ),
          Text(
            value,
            style:
                buttonTextStyle().copyWith(fontSize: 16, color: konDarkColorB1),
          ),
        ],
      ),
    );
  }
}
