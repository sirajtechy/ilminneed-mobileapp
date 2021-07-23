import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LessonContentHeaderWidget extends StatelessWidget {
  final String value;

  const LessonContentHeaderWidget({Key key, @required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: buttonTextStyle().copyWith(color: konDarkColorB1),
          ),
          SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1/2',
                  style: mediumTextStyle().copyWith(color: konDarkColorD3)),
              SizedBox(width: 5),
              Text(
                '.',
                style: mediumTextStyle().copyWith(color: konDarkColorD3),
              ),
              SizedBox(width: 5),
              Text(
                '',
                style: mediumTextStyle().copyWith(color: konDarkColorD3),
              ),
            ],
          )
        ],
      ),
    );
  }
}
