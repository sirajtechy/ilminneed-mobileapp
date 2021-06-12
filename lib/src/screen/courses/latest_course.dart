import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LatestCourse extends StatelessWidget {
  const LatestCourse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.all(5),
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff4481EB),
                    Color(0xff04BEFE),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Declarative interfaces for any Apple Devices.. ',
                    softWrap: true,
                    style: smallTextStyle()
                        .copyWith(fontSize: 14, color: konDarkColorB1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    'By Shamsudeen',
                    style: smallTextStyle()
                        .copyWith(fontSize: 12, color: konLightColor3),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        star,
                        height: 15,
                      ),
                      Text(
                        ' 4.5 ',
                        style: buttonTextStyle()
                            .copyWith(fontSize: 12, color: konDarkColorD3),
                      ),
                      Text(
                        ' (1.2k) ',
                        style:
                            mediumTextStyle().copyWith(color: konLightColor3),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    "8500.00",
                    style: mediumTextStyle().copyWith(
                        fontSize: 14,
                        color: konDarkColorB1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
