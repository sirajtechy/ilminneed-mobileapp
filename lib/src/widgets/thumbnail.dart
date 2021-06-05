import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ThumbNailWidget extends StatelessWidget {
  final bool continueLearing;

  const ThumbNailWidget({Key key, this.continueLearing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: !continueLearing
                    ? BoxDecoration(
                        color: konImageBGColor,
                        borderRadius: BorderRadius.circular(8),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          Color(0xffFF6188),
                          Color(0xffFFB199),
                        ])),
                child: SvgPicture.asset(
                  laptop,
                  height: 100,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: konBlackTextColor),
                  child: Text(
                    '12.15',
                    style:
                        mediumTextStyle().copyWith(color: konButtonTextColor),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'IT & Technology',
              style: smallTextStyle()
                  .copyWith(fontSize: 10, color: konTextInputBorderFillColor),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'Declarative interfaces for any Apple Devices..',
              style: smallTextStyle()
                  .copyWith(fontSize: 14, color: konTextInputBorderTextColor),
            ),
          ),
          !continueLearing
              ? Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    'By Shamsudeen',
                    style: smallTextStyle().copyWith(
                        fontSize: 12, color: konTextInputBorderFillColor),
                  ),
                )
              : Container(),
          !continueLearing
              ? Container(
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
                            .copyWith(fontSize: 12, color: konRatingTextColor),
                      ),
                      Text(
                        ' (1.2k) ',
                        style: mediumTextStyle()
                            .copyWith(color: konTextInputBorderFillColor),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
