import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class CourseFeatureWidget extends StatelessWidget {
  final Color iconColor, iconBGColor;
  final IconData icon;
  final String value1, value2;

  const CourseFeatureWidget(
      {Key key,
      this.iconBGColor,
      this.iconColor,
      this.value1,
      this.value2,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: iconBGColor, borderRadius: BorderRadius.circular(5)),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value1,
                  style: largeTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB1),
                ),
                Text(
                  value2,
                  style: mediumTextStyle()
                      .copyWith(fontSize: 14, color: konDarkColorD3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
